#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt update

# Install required packages
echo "Installing required packages..."
sudo apt-get install wget software-properties-common dirmngr ca-certificates apt-transport-https -y

# Install MariaDB
echo "Installing MariaDB..."
sudo apt install mariadb-server mariadb-client -y

# Check MariaDB version
echo "Checking MariaDB version..."
mariadb --version

# Check MariaDB status
echo "Checking MariaDB status..."
sudo systemctl status mariadb

# Execute MariaDB script for secure installation
echo "Executing MariaDB secure installation script..."
sudo mysql_secure_installation

# Prompt user to create new MariaDB user
read -p "Do you want to create a new MariaDB user? (y/n)" choice
if [ "$choice" == "y" ]; then
    read -p "Enter the new user name: " username
    read -p "Enter the new user password: " password

    # Prompt user to choose which types of privileges to grant
    read -p "Which types of privileges do you want to grant to '$username'? (all/create/read/update/delete): " privileges

    # Create new MariaDB user and grant chosen privileges
    echo "Creating new MariaDB user '$username'..."
    sudo mariadb -e "CREATE OR REPLACE USER '$username'@'localhost' IDENTIFIED BY '$password';"
    case $privileges in
        all)
            sudo mariadb -e "GRANT ALL PRIVILEGES ON *.* to '$username'@'localhost';"
            ;;
        create)
            sudo mariadb -e "GRANT CREATE PRIVILEGE ON *.* to '$username'@'localhost';"
            ;;
        read)
            sudo mariadb -e "GRANT SELECT PRIVILEGE ON *.* to '$username'@'localhost';"
            ;;
        update)
            sudo mariadb -e "GRANT UPDATE PRIVILEGE ON *.* to '$username'@'localhost';"
            ;;
        delete)
            sudo mariadb -e "GRANT DELETE PRIVILEGE ON *.* to '$username'@'localhost';"
            ;;
        *)
            echo "Invalid choice. No privileges granted."
            ;;
    esac
else
    echo "Skipping user creation."
fi

