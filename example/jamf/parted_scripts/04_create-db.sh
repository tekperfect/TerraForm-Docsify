#!/usr/bin/env bash

########################
### SCRIPT VARIABLES ###
########################

source .env

####################
### SCRIPT LOGIC ###
####################

# Check Jamf Pro Server Tools CLI version
jamf-pro --version

# Create Jamf Pro Database and MySQL User Account
sudo jamf-pro database init

# Enter your MySQL root password


# Set new MySQL root password, press Enter to skip


# Enter name of Jamf Pro database


# Enter username of Jamf Pro user


# Press "Y" if you want to save the database connection settings to the Jamf Pro configuration (DataBase.xml)


# Pres "Y" if you want to save the username and password to the Jamf Pro Server Tools CLI configuration file


