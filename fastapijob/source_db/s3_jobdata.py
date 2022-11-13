import json
import boto3

s3 =boto3.resource('s3')
job_bucket= "job-json-id-bucket"
bucket =s3.Bucket(job_bucket)

def list_job():
    job_ids=[]
    for obj in bucket.object.all():
        job_ids.append(obj.key[:-5])
    return job_ids   

def get_job_data(id):
    obj= s3.object(job_bucket, id + ".json")
    job_string = obj.get()['Body'].read().decode('utf-8')
    return json.loads(job_string)