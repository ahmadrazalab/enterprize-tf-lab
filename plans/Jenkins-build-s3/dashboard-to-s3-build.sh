# Prerequisites : 
- git-repo-url
- aws-s3-access-key
- environment-node



-----
node -v  # 20.16
npm install --force
# building and transferring the files to CF 
cp -r ./src/environments.example ./src/environments
ls ./src/environments.example
ls ./src/environments
cat ./src/environments/environment.prod.ts
npm run ng build --configuration=production

# Jenkins AWS Plugin: You can also use the Jenkins AWS S3 plugin to simplify the S3 upload step.
# Define variables
S3_BUCKET="s3://static-website-v0-datacenter"  # Replace with your S3 bucket name
BUILD_DIR="dist"                # Directory to upload

# Upload the build directory to S3
aws s3 sync $BUILD_DIR $S3_BUCKET
echo "Files transferred to S3 bucket: $S3_BUCKET"

# Sentry Req send 
curl https://logs.seamlessfintech.com/api/hooks/release/builtin/4/1661ccf3965dcf54f542c560fec98e6a181c8c1aa701e98a699090c631f8a6f7/ \
  -X POST \
  -H 'Content-Type: application/json' \
  -d '{"version": "v0.7.41"}'