# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

data "aws_ssm_parameter" "lambda_slack_webhook" {
  name = "lambda_slack_webhook"
}

# __generated__ by Terraform
resource "aws_lambda_function" "notify_cost_function" {
  architectures                  = ["x86_64"]
  code_signing_config_arn        = null
  description                    = null
  filename                       = "lambda_function.py"
  function_name                  = "Notify-AWS-Cost"
  handler                        = "lambda_function.lambda_handler"
  # image_uri                      = null
  kms_key_arn                    = null
  layers                         = []
  memory_size                    = 128
  package_type                   = "Zip"
  publish                        = null
  reserved_concurrent_executions = -1
  role                           = "arn:aws:iam::776811705601:role/NotifyCost"
  runtime                        = "python3.7"
  # s3_bucket                      = null
  # s3_key                         = null
  # s3_object_version              = null
  skip_destroy                   = false
  source_code_hash               = "SX0jypJl6Q/LXreyOu2a+aNQ89cqgsV9AnM08urPHh4="
  tags                           = {}
  tags_all                       = {}
  timeout                        = 6
  environment {
    variables = {
      lambda_slack_webhook = data.aws_ssm_parameter.lambda_slack_webhook.value
    }
  }
  ephemeral_storage {
    size = 512
  }
  tracing_config {
    mode = "PassThrough"
  }
}

# __generated__ by Terraform from "arn:aws:iam::776811705601:policy/NotifyCostLambdaToSlack"
resource "aws_iam_policy" "notify_cost_policy" {
  description = null
  name        = "NotifyCostLambdaToSlack"
  name_prefix = null
  path        = "/"
  policy      = "{\"Statement\":[{\"Action\":\"ce:GetCostAndUsage\",\"Effect\":\"Allow\",\"Resource\":\"*\",\"Sid\":\"VisualEditor0\"}],\"Version\":\"2012-10-17\"}"
  tags        = {}
  tags_all    = {}
}

# __generated__ by Terraform from "NotifyCost"
resource "aws_iam_role" "notify_cost_role" {
  assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
  description           = "Allows Lambda functions to call AWS services on your behalf."
  force_detach_policies = false
  managed_policy_arns   = ["arn:aws:iam::776811705601:policy/NotifyCostLambdaToSlack"]
  max_session_duration  = 3600
  name                  = "NotifyCost"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}
