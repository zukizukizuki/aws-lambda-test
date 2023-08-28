import { DynamoDB } from 'aws-sdk'
import crypto from 'crypto'

export async function list(evnet, context) {
  const dynamodb = new DynamoDB({
    region: 'ap-northeast-1'
  })

  const result = await dynamodb
    .scan({
      TableName: 'tasks'
    })
    .promise()

  const tasks = result.Items.map((item) => {
    return {
      id: item.id.S,
      title: item.title.S
    }
  })

  return { tasks: tasks }
}

export async function post(event, context) {

//   event からリクエストの内容を取り出す
  const requestBody = JSON.parse(event.body)

// 保存するアイテムを取り出す
  const item = {
    id: { S: crypto.randomUUID() },
    title: { S: requestBody.title }
  }

  const dynamodb = new DynamoDB({
    region: 'ap-northeast-1'
  })

// putItemでDBに保存
  await dynamodb
    .putItem({
      TableName: 'tasks',
      Item: item
    }).promise()

  return item
}
