# letsencrypt-security-onion
automating SSL renewal for Security Onion

Projects used

https://go-acme.github.io/lego/dns/cloudflare/

https://securityonionsolutions.com

These 2 scripts make the following assumptions
- they will be run from /etc/letsencrypt-scripts
- lego is installed
- you are using Cloudflare for your certs
- you've created and tested a token for DNS
- variables are stored in /etc/letsencrypt-scripts as individual files for each variable
- they must be named exaclty as in the script

**More info here including super exhaustive install instructions-**

https://servicemax.com.au/tips/letsencrypt-for-security-onion/


**Here's the short version**

- get a token with the correct permissions from Cloudflare
- install Lego
- download the scripts into /etc/letsencrypt-scripts
- add your creds as files in the same folder
- run the Lego enrol command to generate your scripts first
- add the le-renew script to crontab

