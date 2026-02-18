


resource "aws_iam_policy" "adminPower" {
     
     name = "AdminPower"
     description = "for practice purpose"
     policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Action = "*"
                Resource = "*"
            }
        ]
     })
  
}

resource "aws_iam_role" "forELasticCloud" {
       
      name = "forPoweringeEc2"
      description = "powering Ec2"

      assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect ="Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"

                }
                Action = "sts:AssumeRole"
            }
        ]
      })
      
  
}

resource "aws_iam_role_policy_attachment" "assignPolicyRole" {
      role = aws_iam_role.forELasticCloud.name
      policy_arn = aws_iam_policy.adminPower.arn
  
}


resource "aws_iam_user" "practiceUsers" {

    name = "PracticeUser"
  
}

resource "aws_iam_user_login_profile" "consoleLogin" {

    user = aws_iam_user.practiceUsers.name
    password = "mySimplePassword@123"
    password_reset_required = false
  
}
resource "aws_iam_access_key" "practiceKey" {

    user = aws_iam_user.practiceUsers.name
  
}

output "practice_user_access_key_id" {
  value = aws_iam_access_key.practiceKey.id
  sensitive = true
}

output "practice_user_secret_access_key" {
  value = aws_iam_access_key.practiceKey.secret
  sensitive = true
}


resource "aws_iam_user_policy_attachment" "policyAttachmentforuser" {
     user = aws_iam_user.practiceUsers.name
     policy_arn = aws_iam_policy.adminPower.arn

  
}