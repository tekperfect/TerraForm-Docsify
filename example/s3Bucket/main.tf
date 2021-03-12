# if any rescource depicted here take longer than a 30sec there is an error
resource "aws_s3_bucket" "b" {
  bucket = "ninja-is-struggles"
  # Bucket name must be truly unique among all users, mention here: https://aws.amazon.com/premiumsupport/knowledge-center/s3-error-bucket-already-exists/
  #policy = file("bucket-policy.json") # Path to .json file

  tags = {
    Name        = "tf test bucket"
    Environment = "Dev"

  }
}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17" # Aws Version is NOT the version of the policy you are creating but a specific aws policy version
    Id      = "SourceIp"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.b.arn,
          "${aws_s3_bucket.b.arn}/*", # if arn is known before creation you can do policy = 
        ]
        Condition = {
          NotIpAddress = {
            "aws:SourceIp" : [
              # Change These IPs to allow only those ips to access the bucket / you can't destroy if it's not one of the ips
              # IMPORTANT:  Make sure to add the machine that apply terraform changes or the bucket will not accept changes e.g Can't destroy
              # If you are even a little be not sure, ask someone who does!!!
              # ip/cidir
            ]
          }
        }
      },
    ]
  })
}
