locals {
    zip_location = "./lambda_function.zip"
}

data "archive_file" "lambda_function" {
    type        = "zip"
    source_file = "resizePy_lambda.py"
    output_path = local.zip_location
}

resource "aws_lambda_function" "resizePy_lambda" {
  filename      = local.zip_location
  function_name = "resizePy_lambda"
  role          = aws_iam_role.resizepylambda_role.arn
  handler       = "resizePy_lambda.lambda_handler"
  description   = "The function download and resize an object from one bucket and store it in another bucket"

  #source_code_hash = filebase64sha256(local.zip_location)

  runtime = "python3.8"

  layers = ["arn:aws:lambda:us-east-1:770693421928:layer:Klayers-python38-Pillow:7"]
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.resizePy_lambda.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.originbucket-jak.arn
}