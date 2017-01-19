# On Your Machine

1. Define your RP Identifier via `ENV['RP_IDENTIFIER']`
  * See `config/initializers/rp_certification.rb` for more details.
2. Run app via Pow
  * e.g.) https://rp-certified.dev
3. Run tunnelss by `sudo tunnels`
  * RP Conformance Test requires `https` URLs as `redirect_uri`
4. Access to https://rp-certified.dev
5. Start watching `development.log`
  * `tail -f log/development.log`
6. Run each test case by clicking the block
7. Detect whether the test passed or not based on the browser output & log.

# On Heroku

This RP is running at https://connect-rp-certified.herokuapp.com.