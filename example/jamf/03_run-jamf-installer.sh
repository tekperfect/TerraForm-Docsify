#!/usr/bin/env bash

########################
### SCRIPT VARIABLES ###
########################

user=jamfadmin
home='/home/jamfadmin/'
scripts='/home/jamfadmin/scripts/'
jamf_install='/home/jamfadmin/jamf_install'
jamf_version=10.26.1
password=1q2w3e4r5t

####################
### SCRIPT LOGIC ###
####################

# Add exception for Jamf, SSH, and then enable UFW firewall
ufw status
ufw --force enable
ufw allow 8443/tcp
ufw allow OpenSSH
ufw reload

# Change directory
cd ${jamf_install}/${jamf_version}

# Unzip Jamf Pro zip file
unzip ${jamf_install}/${jamf_version}/jamf*.zip

# Run the Jamf Pro installer
sh ${jamf_install}/${jamf_version}/jamfproinstaller.run -- -y

# Configure Pro to start automatically when the server is rebooted
systemctl is-enabled jamf.tomcat8.service
systemctl enable jamf.tomcat8
systemctl is-enabled jamf.tomcat8.service
systemctl start jamf.tomcat8

# Launch 04_create-db.sh
# sh ${scripts}/04_create-db.sh
