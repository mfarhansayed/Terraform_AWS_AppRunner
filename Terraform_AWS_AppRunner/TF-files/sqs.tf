resource "aws_sqs_queue" "sqs_queue" {
  count                             = var.create_sqs_queue == true ? 1 : 0
  content_based_deduplication       = false
  deduplication_scope               = null
  delay_seconds                     = 0
  fifo_queue                        = false
  fifo_throughput_limit             = null
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 1209600
  name                              = var.sqs_queue_name
  name_prefix                       = null
  policy                            = file("${path.module}/${var.env}/sqs_queue_policy.json")
  receive_wait_time_seconds         = 0
  redrive_allow_policy              = null
  redrive_policy                    = null
  sqs_managed_sse_enabled           = true
  tags = {
    Name    = "project_name-SQS"
    project = "project_name"
  }
  visibility_timeout_seconds = 60
}


