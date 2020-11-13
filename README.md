# Lambda Function to resize images

Still on my journey to master Terraform and solve real business case situation using Lambda functions

## The infrastructure is coded in Terraform
    - Create 2 buckets
    - Create 1 lambda role with a policy
    - zip the given function code
    - Deploy the Lambda function with the trigger event
    - The function is deployed with a layer pulled from https://github.com/keithrozario/Klayers
    Thank you to its authors and contributors I spent few hours trying to figure out how to properly build and deploy the layer until I found this resources.

## The function is written in Python 3.8
    - The main libraries here are boto3 and PIL 
    - Download the image added to the origin bucket in S3
    - Resizes the image
    - Upload the resized image to a destination bucket in S3
The reason for the layer is that AWS does not have the PIL in its library and the way around here is to package that in a zip file and add to the lambda function as a layer. The code will pull needed function from the layer.
