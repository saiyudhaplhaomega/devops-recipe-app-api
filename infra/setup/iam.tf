###############################################
# Create IAM user and policy for CD deployment#
###############################################

resource "aws_iam_user" "cd" {
  name = "recipe-app-api-cd"
}

resource "aws_iam_access_key" "cd" {
  user = aws_iam_user.cd.name
}

###########################################
# Policy for TF backend to S3 and Dynamodb#
###########################################
data "aws_iam_policy_document" "tf_backend" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.tf_state_bucket}",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]
    resources = [
      #this tf-state-setup is the key defined in backend configuration in main.tf in deploy
      "arn:aws:s3:::${var.tf_state_bucket}/tf-state-deploy/*",
      #this tf-state-deploy-env is automatically created when state is created
      "arn:aws:s3:::${var.tf_state_bucket}/tf-state-deploy-env/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:UpdateItem",
    ]
    resources = [
      "arn:aws:dynamodb:*:*:table/${var.tf_state_lock_table}",
    ]
  }
}
################################################################### 
# Data block creates policies and Resource block creates resources#
################################################################### 

################################################################### 
# Create IAM Policy#
################################################################### 

resource "aws_iam_policy" "tf_backend" {
  name        = "${aws_iam_user.cd.name}-tf-s3-dynamodb"
  description = "Allow user to use S3 and DynamoDB for Terraform backend"
  policy      = data.aws_iam_policy_document.tf_backend.json
}
#this attaches to the policy resource we created above to the user created on line 5
resource "aws_iam_user_policy_attachment" "tf_backend" {
  user       = aws_iam_user.cd.name
  policy_arn = aws_iam_policy.tf_backend.arn
}

#now we will define outputs to get the access key and secret key
# which we doing in a seperate file outputs.tf
