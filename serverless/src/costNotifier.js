import { IncomingWebhook } from '@slack/webhook'
import moment from 'moment'
import AWS from 'aws-sdk'

export async function handler(evnet, context) {
  const now = moment()
  const start = now.format("YYYY-MM-01")
  const end = now.add(1, 'months').format('YYYY-MM-01')

  const ce = new AWS.CostExplorer({region: 'us-east-1'})
  const params = {
    TimePeriod: {
      Start: start,
      End: end
    },
    Granularity: 'MONTHLY',
    Metrics: ['UnblendedCost']
  }
  const costAndUsage = await ce.getCostAndUsage(params).promise()
  const usdCost = costAndUsage.ResultsByTime[0].Total.UnblendedCost.Amount

  const slackWebhookUrl = process.env.SLACK_WEBHOOK_URL
  const slackWebhook = new IncomingWebhook(slackWebhookUrl)
  await slackWebhook.send(`今月のAWS使用料：${usdCost}ドル`)
}
