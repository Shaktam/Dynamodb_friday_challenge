resource "aws_dynamodb_table" "job_dynodb" {
  name             = "Job_dynodb"
  hash_key         = "Job-Id"
  range_key        = "Job-Title"
  stream_enabled   = true
  write_capacity   = 5
  read_capacity    = 5
  stream_view_type = "KEYS_ONLY"

  attribute {
    name = "Job-Id"
    type = "S"
  }

  attribute {
    name = "Job-Title"
    type = "S"
  }
  
    tags = {
    Name        = "dynamodb-job-table"
  }
}


