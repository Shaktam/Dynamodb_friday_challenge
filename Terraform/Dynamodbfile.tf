resource "aws_dynamodb_table" "job_dynodb" {
  name             = "Job_dynodb"
  hash_key         = "Job-Title"
  range_key        = "Job-Id"
  stream_enabled   = true
  write_capacity   = 5
  read_capacity    = 5
  stream_view_type = "KEYS_ONLY"

  attribute {
    name = "Job-Title"
    type = "S"
  }

  attribute {
    name = "Job-Id"
    type = "S"
  }

  replica {
    region_name = "us-west-2"
  }

    tags = {
    Name        = "dynamodb-job-table"
  }
}


