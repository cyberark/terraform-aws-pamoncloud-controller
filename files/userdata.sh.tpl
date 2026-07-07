#!/bin/bash
set -e

# Update and install required packages
dnf update -y
dnf install -y unzip python3-pip sshpass

# Install Packer
PACKER_VERSION="1.13.1"
PACKER_PACKAGE_NAME=$(printf "packer_%s_linux_amd64.zip" $PACKER_VERSION)

curl -LO "https://releases.hashicorp.com/packer/$PACKER_VERSION/$PACKER_PACKAGE_NAME"
unzip "$PACKER_PACKAGE_NAME" -d /usr/local/bin/
rm -f "$PACKER_PACKAGE_NAME"

# Install Python3 requirements
python3 -m pip install "ansible==6.7.0" "ansible-core>=2.13.7" "pywinrm>=0.4.3" "pypsrp>=0.5.0" jq

mount -o remount,size=600M /tmp

# Set HOME for AWS CLI to avoid configuration errors
export HOME=/root

# Verify installation
packer version
ansible --version
python3 --version
aws --version

# Download PAMonCloud BYOI file from S3
aws s3 cp "s3://${s3_bucket_name}/${s3_file_name}" "/home/ec2-user"

# Unzip downloaded file as ec2-user to maintain proper ownership
cd /home/ec2-user || exit 1
sudo -u ec2-user unzip "${s3_file_name}" -d PAMonCloud_BYOI
rm -f "${s3_file_name}"

# Validate BYOI toolkit extraction
if [ -d "/home/ec2-user/PAMonCloud_BYOI/CorePAS" ]; then
    echo "BYOI toolkit extracted successfully"
else
    echo "ERROR: BYOI toolkit extraction failed - CorePAS directory not found"
    exit 1
fi

echo "Setup complete!"