#!/usr/bin/env bash

########################
### SCRIPT VARIABLES ###
########################

home='/home/jamfadmin/'
source ${home}/.env

####################
### SCRIPT LOGIC ###
####################

# Add scripts and installer directories
# Create /home/jamfadmin/scripts/

mkdir ${scripts}
chmod 0700 ${scripts}   
chown "${user}:${user}" ${scripts}

#Create /home/jamfadmin/jamf_install/
mkdir ${jamf_install}
chmod 0700 ${jamf_install}
chown "${user}:${user}" ${jamf_install}

#Create /home/jamfadmin/jamf_install/10.26.1
mkdir ${jamf_install}/${jamf_version}
chmod 0700 ${jamf_install}/${jamf_version}
chown "${user}:${user}" ${jamf_install}/${jamf_version}

# Install Unzip
apt -y install unzip

# Clean up directory
mv ${home}/jamf-pro-installer* ${jamf_install}/${jamf_version}
mv ${home}/jamfdb-install.sh ${scripts}

# Update apt
apt update

# REGION 02

# Install OpenJDK 11
apt -y install openjdk-11-jdk

# change selected Java version
update-alternatives --config java

# Set the Java path by executing the following command
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$PATH:$JAVA_HOME/bin

# Change directory
cd /tmp

# Download MySQL 8.0
wget -c https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb
export DEBIAN_FRONTEND="noninteractive"
sudo echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.0" | sudo debconf-set-selections
dpkg -i mysql-apt-config_0.8.16-1_all.deb

# Update apt
apt update

# Install MySQL
sudo echo "mysql-community-server mysql-community-server/root-pass password $password" | sudo debconf-set-selections
sudo echo "mysql-community-server mysql-community-server/re-root-pass password $password" | sudo debconf-set-selections
sudo echo "mysql-community-server mysql-community-server/default-auth-override select Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)" | sudo debconf-set-selections

export DEBIAN_FRONTEND="noninteractive"
apt -y install mysql-server

# ENDREGION

# REGION 03

# Add exception for Jamf, SSH, and then enable UFW firewall
ufw status
ufw --force enable
ufw allow 8443/tcp
ufw allow from ${subnet} to any port 3306
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

# ENDREGION

# REGION 05

# Create Database
mysql -u root -e "CREATE DATABASE jamfsoftware;"
mysql -u root -e "CREATE USER '${database_user}'@'localhost' IDENTIFIED WITH mysql_native_password BY '${password}';"
mysql -u root -e "GRANT ALL ON jamfsoftware.* TO '${database_user}'@'localhost';"


# Set the innodb_buffer_pool_size value to an appropriate size for your server
sudo jamf-pro database config set --innodb-buffer-pool-size 12G

# Set the innodb_file_per_table value to true
sudo jamf-pro database config set --innodb-file-per-table true

# ENDREGION

# REGION 06

# Stop Tomcat
sudo jamf-pro server stop

# Add MySQL command
mysql -u root -e "ALTER USER '${database_user}'@'localhost' IDENTIFIED with mysql_native_password BY '${database_password}';"
mysql -u root -e "CREATE USER '${database_user}'@'${jamf_subnet}' IDENTIFIED BY '${database_password}';"
mysql -u root -e "GRANT ALL ON ${database_name}.* TO '${database_user}'@'${jamf_subnet}';"
mysql -u root -e "ALTER USER '${database_user}'@'${jamf_subnet}' IDENTIFIED with mysql_native_password BY '${database_password}';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${mysql_root_password}';"

# Add to my.cnf file
sudo echo "default-authentication-plugin=mysql_native_password" >> /etc/mysql/my.cnf

# Configure Jamf-Pro MySQL
jamf-pro config set --database-host ${database_host}
jamf-pro config set --database-name ${database_name}
jamf-pro config set --database-user ${database_user}
jamf-pro config set --database-password ${database_password}

# Restart MySQL
sudo jamf-pro database restart

# Start Tomcat
sudo jamf-pro server start

# Remove .env file
rm ${home}/.env

# Change directory
cd ${home}

# ENDREGION