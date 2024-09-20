#!/bin/bash
# Update and install necessary packages
sudo apt update -y 
sudo apt install nginx -y 
echo "<h1>Hello, This is Test Web Page Hosted on the server $(hostname -f). </h1>" > /var/www/html/index.html
echo "<h1> Thanks To Visit </h1>" >> /var/www/html/index.html

# # Setting up a PHP-based application server
# sudo apt install net-tools -y 
# timedatectl set-timezone Asia/Kolkata

# # Install PHP setup
# sudo apt update -y 
# sudo apt upgrade -y 

# # Install PHP 8.2
# sudo apt install software-properties-common -y 
# sudo add-apt-repository ppa:ondrej/php -y
# sudo apt update -y 
# sudo apt install php8.2 -y 
# sudo apt update -y  
# sudo apt-get install -y  php8.2-fpm php8.2-cli php8.2-common php8.2-json php8.2-opcache php8.2-mysql php8.2-mbstring php8.2-xml php8.2-gd php8.2-curl
# sudo systemctl restart php8.2-fpm
# sudo apt install composer -y 
# sudo snap install --classic certbot -y 

# # Cloning the repository to the server nginx path
# sudo apt install git -y 

# # Replace GITHUB_TOKEN with your personal access token
# GITHUB_TOKEN="your_personal_access_token"
# REPO_URL="https://$GITHUB_TOKEN@github.com/yourusername/yourrepository.git"
# sudo git clone $REPO_URL /var/www/html/yourrepository
# git checkout tags/v0.0.1

# # Fetch secret manager and update the .env file
# SECRET_NAME="your-secret-name"
# REGION="your-region"

# # Install AWS CLI
# sudo apt install awscli -y

# # Fetch the secret and update .env file
# aws secretsmanager get-secret-value --secret-id $SECRET_NAME --region $REGION --query SecretString --output text > /var/www/html/yourrepository/.env
# composer install 
# php artisan key:generate

# # Change ownership to the web server user
# sudo chown -R www-data:www-data /var/www/html/yourrepository
# sudo chmod -R 777 /var/www/html/yourrepository/storage

# # Run composer install
# cd /var/www/html/yourrepository
# composer install

# # setup nginx config
# cat << 'EOF' | sudo tee /etc/nginx/sites-available/api
# server {
#     listen 80 default_server;
#     listen [::]:80 default_server;

#     server_name _;

#     root /var/www/html/yourrepository/public;
#     index index.php index.html index.htm;

#     location / {
#         try_files $uri $uri/ /index.php?$query_string;
#     }

#     location ~ \.php$ {
#         include snippets/fastcgi-php.conf;
#         fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
#         fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
#         include fastcgi_params;
#     }

#     location ~ /\.ht {
#         deny all;
#     }
# }
# EOF

# # enable the configuration
# ln -s /etc/nginx/sites-available/api /etc/nginx/sites-enables

# # Restart nginx to apply changes
# sudo systemctl restart nginx
