import boto3

dynamodb = boto3.resource('dynamodb')

table = dynamodb.create_table (
    TableName = 'Job_Crawlers',
       KeySchema = [
           {
               'AttributeName': 'Job-Id',
               'KeyType': 'HASH'
           },
           {
               'AttributeName': 'Job-Title',
               'KeyType': 'RANGE'
           }
           ],
           AttributeDefinitions = [
               {
                   'AttributeName': 'Job-Id',
                   'AttributeType': 'S'
               },
               {
                   'AttributeName':'Job-Title',
                   'AttributeType': 'S'
               }
            ],
            ProvisionedThroughput={
                'ReadCapacityUnits':1,
                'WriteCapacityUnits':1
            }          
    )
print(table)
