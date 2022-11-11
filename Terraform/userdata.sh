#!/bin/bash

cd ..
python3 creates3_bucket.py

cd terraform 

cd /home/ec2-user
aws s3 cp s3://job-notifier-dynodb-bucket/
