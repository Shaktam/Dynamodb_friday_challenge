resource "aws_lambda_function" "job_crawler_db" {
  function_name = "job_crawler_db"
  s3_bucket     = "job-notifier-dynodb-bucket"
  s3_key        = "job_crawler_db.zip"
  role          = "arn:aws:iam::467749311079:role/LabRole"
  handler       = "crawler.handler"
  timeout       = 300
  runtime       = "python3.9"
  layers = [aws_lambda_layer_version.requests_db_layer.arn]

}


resource "aws_lambda_layer_version" "requests_db_layer" {
  s3_bucket     = "job-notifier-dynodb-bucket"
  s3_key        = "requests-db-layer.zip"
  layer_name    = "requests-db-layer"

  compatible_runtimes = ["python3.9"]
}

resource "aws_cloudwatch_event_rule" "every_five_minutes" {
    name = "every-five-minutes"
    description = "Fires every five minutes"
    schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "job_crawler_every_five_minutes" {
    rule = aws_cloudwatch_event_rule.every_five_minutes.name
    target_id = "crawl-db-jobs"
    arn = aws_lambda_function.job_db_crawler.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_job_crawler" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.job_db_crawler.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.every_five_minutes.arn
}