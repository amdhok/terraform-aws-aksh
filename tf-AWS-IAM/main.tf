terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
  }
}

provider "aws" {
    region = "eu-north-1"
}

locals {
  user_data = yamldecode(file("./users.yaml")).users
  user_role_pair = flatten([for user in local.user_data: [for role in user.roles: {
    username = user.username
    role = role
  }]])
}

output "user_data" {
    value = local.user_role_pair
}

#creating users
resource "aws_iam_user" "iam" {
  for_each = toset(local.user_data[*].username)
  name = each.value
}

resource "aws_iam_user_login_profile" "profile" {
  for_each = aws_iam_user.iam
  user = each.value.name
  password_length = 12
  # ... other configuration ...
  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

#attaching policy
resource "aws_iam_user_policy_attachment" "policy" {
  for_each = {
    for pair in local.user_role_pair :
    "${pair.username}-${pair.role}" => pair
  }
  user = aws_iam_user.iam[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}
