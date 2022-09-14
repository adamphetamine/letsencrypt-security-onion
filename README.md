# letsencrypt-security-onion
automating SSL renewal for Security Onion

Projects used

https://go-acme.github.io/lego/dns/cloudflare/

https://securityonionsolutions.com

**Here's the short version**

- get a token with the correct permissions from Cloudflare
- install Lego
- download the scripts into /etc/letsencrypt-scripts
- add your creds as files in the same folder
- run the Lego enrol command to generate your new certificates first
- add the le-renew script to crontab

There are 3 scripts in here
- le-renew for getting and renewing LetsEncrypt certs for Security Onion. Uses DNS challenge, doesn't require port 80 to be open
- move-certs will assist in moving certs into place and restart the web server if new certs are added
- so-postinstall can be used with MDM or Munki to customise so-launcher from Security Onion

We make the following assumptions for the LetsEncrypt scripts-
- scripts will be run from /etc/letsencrypt-scripts
- Lego is installed
- you are using Cloudflare for your certs
- you've created and tested a token for DNS
- variables are stored in /etc/letsencrypt-scripts as individual files for each variable
- they must be named exactly as in the script

**More info here including super exhaustive install instructions-**

https://servicemax.com.au/tips/letsencrypt-for-security-onion/

https://servicemax.com.au/tips/security-onion-automating-mac-host-install-for-fleet/


