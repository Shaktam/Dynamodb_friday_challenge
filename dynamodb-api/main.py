import boto3

enpoint_dburl = "https://www.arbeitnow.com/api/job-board-api"

def load_jobs():
    response = requests.get(url)
    return response.json()["data"]
dynamodb = boto3.resource('dynamodb', endpoint_url="http://localhost:8000")