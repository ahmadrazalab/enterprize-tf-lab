#!/bin/bash

# Define variables
NGINX_DOMAIN_NAME=abc.xyz.com  # Domain name for Nginx, defaults to '_'
GITHUB_REPO_URL="https://<token>@github.com/your-repository/laravel-app.git"  # Default GitHub repository URL

# Update and upgrade packages
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Nginx
sudo apt-get install -y nginx

# Install PHP 8.2 and necessary PHP extensions
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y
sudo apt-get install -y php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-xml php8.2-mbstring php8.2-curl php8.2-zip php8.2-bcmath php8.2-intl

# Configure PHP-FPM to work with Nginx
# sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/8.2/fpm/php.ini
sudo systemctl restart php8.2-fpm

# Install Composer (PHP package manager)
cd /tmp
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Install necessary dependencies for Laravel
sudo apt-get install -y unzip git curl

# Install Node Version Manager (nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install Node.js versions 18, 20, and latest
nvm install 18
nvm install 20
nvm install node # Install latest

# Install Yarn
npm install -g yarn

# Install Angular CLI globally
npm install -g @angular/cli

# Setup Nginx server block for Laravel with a variable domain name
cat <<EOF | sudo tee /etc/nginx/sites-available/$NGINX_DOMAIN_NAME
server {
    listen 80;
    server_name $NGINX_DOMAIN_NAME;

    root /var/www/html/$NGINX_DOMAIN_NAME/public;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# Enable the site and reload Nginx
sudo ln -s /etc/nginx/sites-available/$NGINX_DOMAIN_NAME /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl reload nginx

# Install Laravel application from the specified GitHub repository
cd /var/www/html
sudo git clone $GITHUB_REPO_URL $NGINX_DOMAIN_NAME
cd $NGINX_DOMAIN_NAME
sudo composer install

# Set proper permissions for Laravel
sudo chown -R www-data:www-data /var/www/html/$NGINX_DOMAIN_NAME
sudo chmod -R 755 /var/www/html/$NGINX_DOMAIN_NAME
sudo chmod -R 775 /var/www/html/$NGINX_DOMAIN_NAME/storage
sudo chmod -R 775 /var/www/html/$NGINX_DOMAIN_NAME/bootstrap/cache

# Restart services
sudo systemctl restart nginx
sudo systemctl restart php8.2-fpm
