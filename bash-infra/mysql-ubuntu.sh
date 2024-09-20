#!/bin/bash

# Define variables
MYSQL_ROOT_PASSWORD=root_password   # Root password for MySQL
MYSQL_ADMIN_USER=admin_user         # Admin user to be created
MYSQL_ADMIN_PASSWORD=admin_password # Password for the admin user
MYSQL_READONLY_USER=readonly_user   # Read-only user to be created
MYSQL_READONLY_PASSWORD=readonly_password # Password for the read-only user

# Update and upgrade packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install MySQL server
sudo apt-get install -y mysql-server

# Secure MySQL installation
sudo mysql_secure_installation <<EOF

y
${MYSQL_ROOT_PASSWORD}
${MYSQL_ROOT_PASSWORD}
y
y
y
y
EOF

# Create a MySQL admin user with full access
sudo mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
CREATE USER '${MYSQL_ADMIN_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Create a MySQL read-only user
sudo mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
CREATE USER '${MYSQL_READONLY_USER}'@'localhost' IDENTIFIED BY '${MYSQL_READONLY_PASSWORD}';
GRANT SELECT ON *.* TO '${MYSQL_READONLY_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF

# Restart MySQL service
sudo systemctl restart mysql

# Output the MySQL setup details
echo "MySQL setup completed:"
echo "Admin user: ${MYSQL_ADMIN_USER} with full access" >> /opt/mysql/mysql.info
echo "Read-only user: ${MYSQL_READONLY_USER} with read-only access" >> /opt/mysql/mysql.info
