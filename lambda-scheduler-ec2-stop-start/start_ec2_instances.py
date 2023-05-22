import boto3

ec2 = boto3.resource('ec2', 'us-east-1')

def lambda_handler(event, context):
 instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['stopped']},{'Name': 'tag:AutoStop','Values':['true']}])
 for instance in instances:
     id=instance.id
     ec2.instances.filter(InstanceIds=[id]).start()
