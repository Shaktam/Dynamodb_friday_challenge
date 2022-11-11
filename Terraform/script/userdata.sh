#!/bin/bash

cd terraform 

cd /home/ec2-user
aws s3 cp s3://job-notifier-dynodb-bucket/
unzip fastapijob.zip
pip3 install -r requirements.txt
cd source_db
python3 jobapi_code.py
