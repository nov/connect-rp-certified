# On Your Machine

1. Define your RP Identifier via `ENV['RP_IDENTIFIER']`
  * See `config/initializers/rp_certification.rb` for more details.
2. Run app via Puma-dev
  * e.g.) https://rp-certified.dev
3. Access to https://rp-certified.dev
4. Start watching `development.log`
  * `tail -f log/development.log`
5. Run each test case by clicking the block
6. Detect whether the test passed or not based on the browser output & log.

# On Heroku

This RP is running at https://connect-rp-certified.herokuapp.com.
