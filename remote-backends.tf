#S3

resource "aws_s3_bucket" "remote-s3-bucket" {
   bucket = "state-remote-josh-bucket"

   tags = {
    Name = "state-remote-josh-bucket"
    }
}

#DynamoDB

resource "aws_dynamodb_table" "remote-dynamodb-table" {
  name           = "state-remote-josh-table"
  billing_mode   = "PAY_PER_REQUEST"  #save cost
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"  #string
  }
