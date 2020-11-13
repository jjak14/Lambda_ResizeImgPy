import boto3
import os
import os.path
from pathlib import Path
import sys
from PIL import Image
import PIL.Image

# Create an S3 with boto3
s3 = boto3.client('s3')

# Define a function to resize images;
def resize_image(image_path, resized_path):
    with Image.open(image_path) as image:
        image.thumbnail((200, 200))
        image.save(resized_path)

def lambda_handler(event, context):

    # Read object key from event
    key = event["Records"][0]['s3']['object']['key']
    object_key = key.replace("+", " ") #correct potential issues with key name

    # Construct download path (where the file uploaded from bucket will be saved)
    down_path = '/tmp/' + os.path.basename(object_key)
    
    # Construct upload path (where resized image will be saved locally)
    path = os.path.join('/tmp', 'resized') 
    if os.path.exists(path) == False: #test the existence of the directory before creation
        os.mkdir(path)
    up_path = path + os.path.basename(object_key)

    # Extract the object from origin bucket in S3
    s3.download_file('originbucket-jak', object_key, down_path)
    
    # call the resizing function
    resize_image(down_path, up_path)
        
    # Upload the resized image to the destination bucket
    s3.upload_file(up_path, 'destbucket-jak', object_key)
