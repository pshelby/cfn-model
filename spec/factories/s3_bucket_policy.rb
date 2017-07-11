require 'cfn-model/model/bucket_policy'

def valid_bucket_policy
  statement = Statement.new
  statement.effect = 'Allow'
  statement.actions << '*'
  statement.resources << 'arn:aws:s3:::fakebucketfakebucket/*'
  statement.principal = {
    'AWS' => ['156460612806']
  }

  policy_document = PolicyDocument.new
  policy_document.statements << statement

  bucket_policy = AWS::S3::BucketPolicy.new
  bucket_policy.bucket = {
    'Ref' => 'S3Bucket'
  }
  bucket_policy.policyDocument = policy_document
  bucket_policy
end