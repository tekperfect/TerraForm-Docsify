#!/usr/bin/env bash

########################
### SCRIPT VARIABLES ###
########################

source .env

####################
### SCRIPT LOGIC ###
####################

# # Enter your MySQL root password
read -sp "Your MySQL root password:  " password


read -p "Jamf DB Name: " db_name
read -p "Jamf Username: " username

# Press "Y" if you want to save the database connection settings to the Jamf Pro configuration (DataBase.xml)
read -p "Save to Jamf Pro Config (DataBase.xml): y/n " yn
if [ $yn == "y" ]
then
    echo "Saved Connection"
fi


# Pres "Y" if you want to save the username and password to the Jamf Pro Server Tools CLI configuration file
read -p "Save username and password to Jamf Sever CLI config File: y/n " yn
if [ $yn == "y" ]
then
    echo "Save Creds to Jamf Server"
fi

