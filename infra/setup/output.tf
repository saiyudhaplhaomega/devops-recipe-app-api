## Outputs for CD IAM User Access Keys
# the value will be got from github actions which we will use to deploy
output "cd_user_access_key_id" {
  value       = aws_iam_access_key.cd.id
  description = "Access Key ID for the CD IAM user"
}
# the secret for Iam access key, it allows us to show when we need it
output "cd_user_access_key_secret" {
  value       = aws_iam_access_key.cd.secret
  description = "Secret Access Key for the CD IAM user"
  sensitive   = true

}
