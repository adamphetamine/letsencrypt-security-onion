#!/bin/bash
# this script will move the new certs to the corrrect location, set the permissions and restart the webserver

# If there has been an update then restart the web server
echo "One or more certs were updated. Copying certs and restarting web server...."

# read domain name from file
DOMAIN_NAME=$(<"/etc/letsencrypt-scripts/domain")

# Copy to directory for nginx to use
sudo cp /usr/bin/.lego/certificates/"$DOMAIN_NAME".crt /etc/pki/managerssl.crt
sudo chmod 644 /etc/pki/managerssl.crt
sudo cp /usr/bin/.lego/certificates/"$DOMAIN_NAME".key /etc/pki/managerssl.key
sudo chmod 640 /etc/pki/managerssl.key

# restart the web server
salt-call state.apply nginx
echo "Finished moving certs to correct location and restarted web server!"
