# aws-lambda

## 概要
- awsのlambda関数を用いて以下の機能を実装します。
  - awsの使用料を週に1回通知する機能

## 実行環境
- ~~dockerを使います。~~
- lambdaをterraformかserverless frameworkで管理します。

```text
OS  : ubuntu:20:04
言語 : node:16
```
## Plugin
```
serverless@3.24.1
@slack/webhook@6.1.0
aws-sdk@2
moment@2.29.4
serverless-iam-roles-per-function@3.2.0
serverless-api-gateway-throttling@2.0.2
serverless-s3-sync@3.1.0
```

## コマンドメモ

- dockerのbuild

`docker build -t node-16 .`

- dockerの作成

`docker run --name node-test -it node-16`

- dockerの起動

`docker start node-test`

- dockerの起動

`docker exec -it node-test bash`

- serverlessテンプレートの使用

`serverless create --template aws-nodejs-ecma-script`