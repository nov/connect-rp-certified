This README is an appendix to the documentation at http://openid.net/certification/rp_submission/
specifically for the Rails RP developed using openid_connect gem to explain how this RP meets the
submission criteria and how the results can be reproduced.

All conformance test cases are executed using the Rails RP running on Heroku.
The server is running at https://connect-rp-certified.herokuapp.com.

The Rails RP source code is at https://github.com/nov/connect-rp-certified.
This test result is produced under tag "nov-rp-certified_RP-Basic-20-Jan-2017".

The RP certification test results can be reproduced and verified as follows:


# On Local

1. Run app via Pow (http://pow.cx)
  * symlink the Rails app to `~/.pow/rp-certified`

2. Run tunnelss by `sudo tunnels`
  * RP Conformance Test requires `https` URLs as `redirect_uri`

3. Access to https://rp-certified.dev

4. Start watching `development.log`
  * `tail -f log/development.log`

5. Run each test case by clicking the block

6. Detect whether the test passed or not based on the browser output & log.


# On Heroku

1. Deploy the Rails code to Heroku (or wherever you like).

2. Go to https://what-ever-you-like.herokuapp.com.

3. Tail heroku logs via `heroku logs --tail`

4. Run each test case by clicking the block

5. Detect whether the test passed or not based on the browser output & log.