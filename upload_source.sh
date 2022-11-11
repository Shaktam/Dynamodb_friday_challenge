python3 creates3_bucket.py

mkdir dbbucket

echo" Zip fastapi files for job"
cd fastapijob
zip ../dbbucket/fastapijob.zip requirements.txt
zip -r ../dbbucket/fastapijob.zip source_db
cd ..

echo "upload to s3 bucket"
aws s3 cp dbbucket/fastapijob.zip s3://job-notifier-dynodb-bucket/ 

echo" Zip job-data-api files for job"

cd job-data-api
zip ../dbbucket/job-data-api.zip requirements.txt
zip -r ../dbbucket/job-data-api.zip source_jobapi

cd ..

echo "upload to s3 bucket"
aws s3 cp dbbucket/job-data-api.zip s3://job-notifier-dynodb-bucket/ 

cd requests-layer
pip3 install -r requirements.txt --target python/lib/python3.9/site-packages
zip -r ../dbbucket/requests-layer.zip .
cd ..

echo  "upload to s3 bucket"
aws s3 cp build/requests-layer.zip s3://job-notifier-dynodb-bucket/


