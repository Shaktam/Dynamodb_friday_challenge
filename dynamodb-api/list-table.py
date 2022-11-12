import boto3
from dynamodb_table import create_dynamodb_table

dynamodb = boto3.resource('dynamodb')
def list_table(table):
    print(list(dynamodb.tables.all()))

table =create_dynamodb_table()
list_table(table)