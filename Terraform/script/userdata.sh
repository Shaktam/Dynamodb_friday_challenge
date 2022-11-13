#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
cd terraform 
cd /home/ec2-user
aws s3 cp s3://job-notifier-dynodb-bucket1/
unzip fastapijob.zip
pip3 install -r requirements.txt
cd source_db
python3 jobapi_code.py
