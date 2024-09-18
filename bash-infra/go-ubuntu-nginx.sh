#!/bin/bash

# Define variables
NGINX_DOMAIN_NAME=abc.xyz.com  # Domain name for Nginx, defaults to '_'
GITHUB_REPO_URL="https://<token>@github.com/your-repository/laravel-app.git"  # Default GitHub repository URL
GO_VERSION="1.20.7"


# Update and install necessary packages
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y nginx git curl

# Install Go
wget https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz
sudo tar -xvf go$GO_VERSION.linux-amd64.tar.gz
sudo mv go /usr/local

# Set Go environment variables
echo "export GOROOT=/usr/local/go" >> ~/.profile
echo "export GOPATH=$HOME/go" >> ~/.profile
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> ~/.profile
source ~/.profile

# Clone the Go application (replace with your Go app repository)
git clone $GITHUB_REPO_URL /var/www/$NGINX_DOMAIN_NAME
cd /var/www/$NGINX_DOMAIN_NAME

# Build the Go application
go mod tidy
go mod vendor
go build -o prod-build

# Create a systemd service file for the Go application
sudo tee /etc/systemd/system/$NGINX_DOMAIN_NAME.service > /dev/null <<EOF
[Unit]
Description=$NGINX_DOMAIN_NAME
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/var/www/$NGINX_DOMAIN_NAME
ExecStart=/var/www/$NGINX_DOMAIN_NAME/prod-build
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start the Go application service
sudo systemctl daemon-reload
sudo systemctl enable $NGINX_DOMAIN_NAME.service
sudo systemctl start $NGINX_DOMAIN_NAME.service

# Configure Nginx as a reverse proxy for the Go application
sudo tee /etc/nginx/sites-available/$NGINX_DOMAIN_NAME > /dev/null <<EOF
server {
    listen 80;
    server_name $NGINX_DOMAIN_NAME;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Enable the Nginx configuration and restart Nginx
sudo ln -s /etc/nginx/sites-available/$NGINX_DOMAIN_NAME /etc/nginx/sites-enabled/
sudo systemctl restart nginx


