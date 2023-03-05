import json
import boto3

s3 = boto3.resource('s3')
dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']

    obj = s3.Object(bucket_name, key)
    body = obj.get()['Body'].read().decode('utf-8')
    data = json.loads(body)

    table = dynamodb.Table('dynamodb_lambda')
    response = table.put_item(Item=data)

    return {
        'statusCode': 200,
        'body': json.dumps('Data inserted successfully!')
    }
