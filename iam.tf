resource "aws_iam_role_policy" "resizepylambda_policy" {
  name = "resizepylambda_policy"
  role = aws_iam_role.resizepylambda_role.id
  policy = file("iam/lambda_policy.json")
}

resource "aws_iam_role" "resizepylambda_role" {
  name = "resizepylambda_role"
  assume_role_policy = file("iam/lambda_assume_role_policy.json")
}