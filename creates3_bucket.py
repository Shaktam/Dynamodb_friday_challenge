import boto3

AWS_REGION = "us-west-2"
s3 = boto3.resource('s3')
client = boto3.client('s3',region_name=AWS_REGION)
location = {'LocationConstraint': AWS_REGION}
  

def check_create_s3():
    if s3.Bucket('job-notifier-dynodb-bucket1') in s3.buckets.all():
        print("Bucket job-notifier-dynodb-bucket1 Exists!")
        return True
    else:
        client.create_bucket(Bucket="job-notifier-dynodb-bucket1",CreateBucketConfiguration=location)
        print("Created a new bucket while bucket job-notifier-dynodb-bucket1 does not exist!")
        return False

check_create_s3()

def backend_tfbucket():
    if s3.Bucket('terraform-state-dynodb-bucket') in s3.buckets.all():
        print("Bucket terraform-state-dynodb-bucket Exists!")
        return True
    else:
        client.create_bucket(Bucket="terraform-state-dynodb-bucket",CreateBucketConfiguration=location)
        print("Created a new bucket while bucket terraform-state-dynodb-bucket does not exist!")
        return False

backend_tfbucket()

def create_job_bucket():
    if s3.Bucket('job-json-id-bucket') in s3.buckets.all():
        print("Bucket job-json-id-bucket Exists!")
        return True
    else:
        client.create_bucket(Bucket="job-json-id-bucket",CreateBucketConfiguration=location)
        print("Created a new bucket while bucket job-json-id-bucket does not exist!")
        return False

create_job_bucket()