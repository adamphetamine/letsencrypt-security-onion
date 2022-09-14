#!/bin/sh

# this script will configure a Kolide Launcher downloaded from Security Onion for macOS after it is installed
# add this as a postinstall script to your MDM. Tested with Mosyle
# let's grab some variables
fqdn=so_fqdn           # example 'sec_onion.domain.com'
hostname=so_hostname   # your hostname, not FQDN! Example 'sec_onion'
secret=so_secret       # get this from so by executing 'sudo salt-call pillar.get secrets:fleet_enroll-secret'
port=8090      # external port 8090 for Fleet proxies to 8080 internally via nginx proxy

# Now unload the launchd
launchctl unload /Library/LaunchDaemons/com.so-launcher.launcher.plist

# add the enrol secret to /etc/so-launcher/secret
echo $secret > /etc/so-launcher/secret

# now remove the roots.pem cert so Launcher will rely on the computers' built in cert store
rm -rf /etc/so-launcher/roots.pem

# this is kind of dumb because it could be done more accurately in one step, but it's more flexible?

# add the hostname to the launcher.flags file
sed -i '' "s/fqdn:443/$fqdn:443/" /etc/so-launcher/launcher.flags

# add the port numnber to the launcher.flags file
sed -i '' "s/$fqdn:443/$fqdn:$port/" /etc/so-launcher/launcher.flags

# remove the reference to roots.pem certificate file
sed -i '' "/root_pem/d" /etc/so-launcher/launcher.flags

# reload the launchd
launchctl load /Library/LaunchDaemons/com.so-launcher.launcher.plist

echo 'Kolide Launcher modified successfully'
exit 0
