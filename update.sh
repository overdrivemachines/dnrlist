#!/usr/bin/env bash
# Place this file in /var/www/myapp folder
# Code lives in /var/www/myapp/code

# -u removed
set -eo pipefail
# -e = "Exit on error."" If any command returns a non-zero status (failure), the script exits immediately.
# -u = "Treat unset variables as an error and exit immediately." This helps catch typos and logic errors.
# -o pipefail = "Return the exit status of the last command in the pipeline that failed." This is useful for catching errors in pipelines. Normally, in cmd1 | cmd2 | cmd3, the pipeline’s exit status is just that of the last command (cmd3). With pipefail, the pipeline fails if any command in it fails.

# Friendly error output
# - Fires whenever any command returns non-zero (thanks to -e/pipefail).
# - Prints the line number ($LINENO) where it failed, then exits with status 1.
trap 'echo "ERROR: Line $LINENO failed. Exiting."; exit 1' ERR

# Detect where this script is being run from
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# If someone runs /var/www/<app>/code/update.sh, stop and instruct.
if [[ "$(basename "$SCRIPT_DIR")" == "code" ]]; then
  echo "ERROR: Run this script from /var/www/<app>/update.sh (not /var/www/<app>/code/update.sh)."
  echo "Hint: cd /var/www/<app> && ./update.sh"
  exit 1
fi

# APP_ROOT is always /var/www/<app>/code
APP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/code" && pwd)"
if [[ ! -d "$APP_ROOT" ]]; then
  echo "ERROR: $APP_ROOT does not exist"; exit 1
fi
cd "$APP_ROOT"

# --- Sync repo before reading version files ---
echo "==> Updating code from origin/main"
# get fresh refs, drop stale ones
git fetch --prune
# make tracked files match exactly
git reset --hard origin/main
# remove untracked clutter but keep bundled gems/config
git clean -fd -e vendor -e vendor/bundle -e .bundle

# --- RVM & Ruby from repo files ---

# Ensure RVM is available

# Temporarily relax nounset: RVM uses vars before assignment.
# set +u
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  # shellcheck disable=SC1090
  # ShellCheck warns (SC1090) when you source a dynamic path it can’t statically verify 
  # (e.g., source "$HOME/.rvm/scripts/rvm"). We disable that specific warning because the 
  # path is correct at runtime even though static analysis can’t confirm it.

  source "$HOME/.rvm/scripts/rvm"
else
  echo "ERROR: RVM not found at \$HOME/.rvm/scripts/rvm"; exit 1
fi

RUBY_VERSION="$(tr -d ' \t\r\n' < .ruby-version)"
if [[ -f ".ruby-gemset" ]]; then
  GEMSET="$(tr -d ' \t\r\n' < .ruby-gemset)"
  rvm use "${RUBY_VERSION}@${GEMSET}" --create
else
  rvm use "${RUBY_VERSION}"
fi

# set -u  # Re-enable nounset

# --- Environment for production deploys ---
export RAILS_ENV=production
export NODE_ENV=production
export BUNDLE_WITHOUT="development:test"
export BUNDLE_DEPLOYMENT="true"
export BUNDLE_PATH="${APP_ROOT}/vendor/bundle"
mkdir -p "$BUNDLE_PATH"

# Ensure Bun is on PATH (adjust if installed elsewhere)
export PATH="$HOME/.bun/bin:$PATH"

echo "==> Verifying lockfiles"
[[ -f Gemfile.lock ]] || { echo "ERROR: Gemfile.lock missing"; exit 1; }
[[ -f bun.lock ]] || { echo "ERROR: bun.lock missing"; exit 1; }

echo "==> Installing Ruby gems"
# 2 CPU cores on the droplet
"${APP_ROOT}/bin/bundle" install --jobs 2 --retry 3

echo "==> Installing JS deps (frozen lockfile, production only)"
bun install --frozen-lockfile --production

echo "==> Running database migrations"
"${APP_ROOT}/bin/rails" db:migrate

echo "==> Precompiling assets"
"${APP_ROOT}/bin/rails" assets:precompile

echo "==> Restarting app (Passenger)"
passenger-config restart-app "$APP_ROOT" --ignore-app-not-running

echo '==> Deploy complete.'

# Passenger restart
# mkdir -p tmp && touch tmp/restart.txt
