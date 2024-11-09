provider "aws" {
  region = "us-east-1"
}

# Creating an SNS Topic
resource "aws_sns_topic" "sns_to_sqs" {
  name         = "sns-to-sqs"
  display_name = "SNS to SQS"
}

# Setting up an SQS Queue
resource "aws_sqs_queue" "sns_to_sqs" {
  name = "sns-to-sqs"
}
# Subscribing Our Queue to Our Fanout Topic
resource "aws_sns_topic_subscription" "my_subscription" {
  topic_arn = aws_sns_topic.sns_to_sqs.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sns_to_sqs.arn
}
# Allowing SNS to queue messages in SQS
resource "aws_sqs_queue_policy" "access_policy" {
  queue_url = aws_sqs_queue.sns_to_sqs.url

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Allow-SNS-to-Publish-to-SQS"
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.sns_to_sqs.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.sns_to_sqs.arn
          }
        }
      }
    ]
  })
}

#Testing our Subscription
# Let's publish a new message to our topic:
# aws sns publish \
#    --topic-arn arn:aws:sns:eu-west-1:<account-id>:sns-to-sqs \
#    --message "Hello, world" \
#    --region=eu-west-1
# Let's now poll the message from our SQS topic.
# aws sqs receive-message \
#    --queue-url "https://sqs.eu-west-1.amazonaws.com/<account-id>/sns-to-sqs" \
#    --max-number-of-messages 1 \
#    --region=eu-west-1
#
# aws sqs receive-message \
#    --queue-url "https://sqs.eu-west-1.amazonaws.com/157088858309/sns-to-sqs" \
#    --max-number-of-messages 1 \
#    --region=eu-west-1 \
#    | jq '.Messages[].Body | fromjson | .Message'

# source https://blog.awsfundamentals.com/amazon-sns-to-sqs