resource "aws_s3_bucket" "originbucket-jak" {
  bucket = "originbucket-jak"
  acl    = "private"
}

resource "aws_s3_bucket" "destbucket-jak" {
  bucket = "destbucket-jak"
  acl    = "private"
}

resource "aws_s3_bucket_notification" "the_trigger" {
    bucket = aws_s3_bucket.originbucket-jak.id

    lambda_function {
        lambda_function_arn = aws_lambda_function.resizePy_lambda.arn
        events              = ["s3:ObjectCreated:Put"]
    }

    depends_on = [aws_lambda_permission.allow_bucket]
}