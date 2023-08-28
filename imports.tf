# ロール
import {
  to = aws_iam_role.notify_cost_role
  id = "NotifyCost"
}

# ポリシー
import {
  to = aws_iam_policy.notify_cost_policy
  id = "arn:aws:iam::776811705601:policy/NotifyCostLambdaToSlack"
}

# lambda
import {
  to = aws_lambda_function.notify_cost_function
  id = "Notify-AWS-Cost"
}