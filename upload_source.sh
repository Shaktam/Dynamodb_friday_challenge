python3 creates3_bucket.py

mkdir dbbucket

echo" Zip fastapi files for job"
cd fastapijob
zip ../dbbucket/fastapijob.zip requirements.txt
zip -r ../dbbucket/fastapijob.zip source_db
cd ..

echo "upload to s3 bucket"
aws s3 cp dbbucket/fastapijob.zip s3://job-notifier-dynodb-bucket1/ 

echo" Zip job-data-api files for job"

cd job-data-api/source_jobapi

zip -r ../../dbbucket/job-data-api.zip .

cd ../..

echo "upload to s3 bucket"
aws s3 cp dbbucket/job-data-api.zip s3://job-notifier-dynodb-bucket1/ 

cd requests-layer
pip3 install -r requirements.txt --target python/lib/python3.9/site-packages
zip -r ../dbbucket/requests-layer.zip .
cd ..

echo  "upload to s3 bucket"
aws s3 cp dbbucket/requests-layer.zip s3://job-notifier-dynodb-bucket1/


