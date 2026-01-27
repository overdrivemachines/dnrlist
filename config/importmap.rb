# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Use all.js instead of fontawesome.js
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.2.0/js/all.js"

# From "bootstrap" gem
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true

# List JS
pin "list", to: "list.js", preload: true

# Custom JS
pin "my_script", to: "my_script.js", preload: true
