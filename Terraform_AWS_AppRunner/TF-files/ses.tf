resource "aws_ses_email_identity" "ses_email" {
  count = var.create_ses_email_identity == true ? 1 : 0
  email = var.ses_email

}

resource "aws_ses_domain_identity" "sending_domain" {
  count  = var.create_ses_domain_identity == true ? 1 : 0
  domain = var.sending_domain
}
