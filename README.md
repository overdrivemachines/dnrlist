# README

Do Not Rent List for Hotels

# Ruby version
ruby 3.1.1p18 (2022-02-18 revision 53f5fc4236) [x86_64-linux]
Rails 7.0.2.3

# Standard Steps in all my apps:
- In the Gemfile add:
```
gem "rails-erd"
gem "annotate"
```
  In terminal:
  $ bundle exec rails g erd:install <br>
  $ rails g annotate:install <br>

- Add Bootstrap: <br>
  - In the Gemfile add:
  ```
  gem "sassc-rails"
  gem 'bootstrap', '~> 5.1.3'
  ```
  - In development.rb add:
   ```
   config.sass.inline_source_maps = true
   ```
  - Clear assets cache and rename application.css <br>
  ```
  $ rm -r tmp/cache/assets
  $ mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
  ```
  - In application.scss add:
  ```scss
  @import "bootstrap";
  ```
  - In assets.rb add: <br>
  ```
  Rails.application.config.assets.precompile += %w( application.scss )
  ```
  - Add JS: jquery, bootstrap, popperjs
  ```
  $ ./bin/importmap pin jquery@3.6.0 --download
  $ ./bin/importmap pin bootstrap@5.1.3 --download
  $ ./bin/importmap pin @popperjs/core@2.11.2 --download

  ```
  - In application.js add: <br>
  ```js
  import "bootstrap"
  ```


* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

