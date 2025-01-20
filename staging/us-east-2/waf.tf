resource "aws_wafv2_web_acl" "staging" {
  name        = "staging"
  description = "staging"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  # WAF rule 10 common rule set
  rule {
    name     = "common-rules"
    priority = 10

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "common-rule-metric-name"
      sampled_requests_enabled   = true
    }
  }

  # WAF rule 20 SQL rule set
  rule {
    name     = "sql-rules"
    priority = 20

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SQLi_QUERYARGUMENTS"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SQLi_COOKIE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "sql-rule-metric-name"
      sampled_requests_enabled   = true
    }
  }

  #   tags = {
  #     Tag1 = "Value1"
  #     Tag2 = "Value2"
  #   }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "staging-metric-name"
    sampled_requests_enabled   = true
  }
}

######################################### WAF Association ##############################

resource "aws_wafv2_web_acl_association" "staging" {
  resource_arn = module.staging.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.staging.arn
}
