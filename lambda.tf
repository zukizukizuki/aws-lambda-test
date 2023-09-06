data "aws_ssm_parameter" "LAMBDA_SLACK_WEBHOOK" {
  name = "LAMBDA_SLACK_WEBHOOK"
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "src/lambda_function.py"
  output_path = "src/lambda_function_payload.zip"
}

resource "aws_lambda_function" "notify_cost_function" {
  architectures                  = ["x86_64"]
  filename                       = "src/lambda_function_payload.zip"
  function_name                  = "Notify-AWS-Cost"
  handler                        = "lambda_function.lambda_handler"
  memory_size                    = 128
  package_type                   = "Zip"
  reserved_concurrent_executions = -1
  role                           = "arn:aws:iam::776811705601:role/NotifyCost"
  runtime                        = "python3.7"
  skip_destroy                   = false
  source_code_hash               = "SX0jypJl6Q/LXreyOu2a+aNQ89cqgsV9AnM08urPHh4="
  timeout                        = 6
  environment {
    variables = {
      LAMBDA_SLACK_WEBHOOK = data.aws_ssm_parameter.LAMBDA_SLACK_WEBHOOK.value
    }
  }
  ephemeral_storage {
    size = 512
  }
  tracing_config {
    mode = "PassThrough"
  }
}

resource "aws_iam_policy" "notify_cost_policy" {
  name        = "NotifyCostLambdaToSlack"
  path        = "/"
  policy      = "{\"Statement\":[{\"Action\":\"ce:GetCostAndUsage\",\"Effect\":\"Allow\",\"Resource\":\"*\",\"Sid\":\"VisualEditor0\"}],\"Version\":\"2012-10-17\"}"
}

resource "aws_iam_role" "notify_cost_role" {
  assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
  description           = "Allows Lambda functions to call AWS services on your behalf."
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::776811705601:policy/NotifyCostLambdaToSlack"]
  max_session_duration  = 3600
  name                  = "NotifyCost"
  path                  = "/"
}
