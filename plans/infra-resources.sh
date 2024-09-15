# Paytring-Infra : 
- RDS + RDS-sg
- ec2-primary + sg + EIP
- ec2-pp + sg 
- ec2 (magic-quick-cron-breeze-etc) + SG + EIP  
- alb + tg-1 + tg-2 + asg + alb-sg 
- aws-keypair


# Infra-Other : 
- S3 (dashboard + cdn + checkout)
- CF-OAI
- CF (3) (dash, cdn, checkout)
- SecretM ( API, Magic, Quick, Breeze, UPI-G)


# Outputs : 
- ec2 static ip ips (PP) 
- rds endpoint + read-replica
- rds passwords 
- CF- dns name 
- SecretM Name


# Custom VPC : 
- vpc
- subnet-public (3)
- subnet-private (3)
- route-table
- internet gateway
- enable-dns-hostname
- auto-assgien public ip


# Cloudflare TF : 
- Create and Update the IP > A/CNAME
