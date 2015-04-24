#droptoflare ![travis](https://api.travis-ci.org/jhaals/droptoflare.svg?branch=master)
droptoflare adds your DigitalOcean Droplets as A records in Cloudflare.
droptoflare will update DNS records if you re-create a Droplet with the same name.

### Installation

    gem install droptoflare

Create `~/.droptoflare.yaml` and add the following

    domain: example.com
    email: email_used_at_cloudflare@example.com
    cf_token: Cloudflare t0ken
    do_token: DigitalOcean t0ken'

Run!

    $ droptoflare
    Found 2 Droplets checking IP's against 3 CF records
    Updating test.jhaals.se from 178.62.20.1 to 178.62.20.198
    Updated 1 record(s)

    $ droptoflare
    Found 2 Droplets checking IP's against 3 CF records
    Updated 0 record(s)

### Todo
- more tests
- better error handling
- ability to set TTL (120s at the moment)
