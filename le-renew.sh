#!/bin/bash

# partially lifted from https://medium.com/@adamneilson/automating-lets-encrypt-certificate-renewal-baed06493d3f
# thank you, kind internet stranger!

# debug - comment out this when working
# set -x 

# load settings from file
CLOUDFLARE_EMAIL_FILE=$(<"/etc/letsencrypt-scripts/email") \
CLOUDFLARE_API_TOKEN_FILE=$(<"/etc/letsencrypt-scripts/token") \
DOMAIN_NAME=$(<"/etc/letsencrypt-scripts/domain")

TIMESTAMP=$(date +"%F %T")
UPDATED=0

# debugging time- uncomment these if you want to check your variables are correct
# echo $CLOUDFLARE_EMAIL_FILE
# echo $CLOUDFLARE_API_TOKEN
# echo $DOMAIN_NAME

# UTIL FUNCTION TO LOG ACTIVITY
function log_msg {
    echo "["$TIMESTAMP"] $1" >> $LOG_FILE
}

# set log file location
LOG_FILE="/var/log/letsencrypt/ssl-renewals.log"

# Let's get the certs
echo "Renewing SSL Certificates with Let's Encrypt CA"
# lego binary is in /usr/bin/lego
cd /usr/bin/

# set token  variable
CLOUDFLARE_DNS_API_TOKEN=$CLOUDFLARE_API_TOKEN_FILE \
lego --email $CLOUDFLARE_EMAIL_FILE \
--dns cloudflare \
--domains $DOMAIN_NAME run \
--run-hook "/etc/letsencrypt-scripts/move-certs.sh"

echo "all done. exiting"
