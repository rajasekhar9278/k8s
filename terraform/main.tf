
#Create EC2 instance in default VPC and bootstrap instance to start and install Jenkins
resource "aws_instance" "jenkins-instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  user_data              = <<-EOF
                #!/bin/bash
                sudo apt update –y 
                sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo 
                sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
                sudo apt upgrade
                sudo amazon-linux-extras install java-openjdk11 -y 
                sudo apt install jenkins -y
                sudo systemctl enable jenkins
                sudo systemctl start jenkins
                EOF

  user_data_replace_on_change = true
  tags = {
    Name = "jenkins-EC2"
  }
}

#Create and assign a security group to Jenkins EC2 to allow traffic on port 22 and 8080
resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  description = "Allow traffic on port 22 and port 8080"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow for SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Port 8080 used for web servers"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "virtual port that computers use to divert network traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create S3 bucket for your Jenkins Artifacts not open to the bucket
resource "aws_s3_bucket" "jenkins-bucket" {
  bucket = var.s3bucket
  acl    = var.acl
  tags = {
    description = "Private bucket to hold Jenkins artifacts"
    name        = "jenkins-bucket"
  }
}


#Create IAM role for EC2 to allow S3 read/write access
resource "aws_iam_role" "s3-jenkins-role" {
  name = "s3-jenkins-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

#IAM instance profile for EC2 instance
resource "aws_iam_instance_profile" "s3-jenkins-instance-profile" {
  name = "s3-jenkins-instance-profile"
  role = aws_iam_role.s3-jenkins-role.name
}

#IAM policy for S3 access
resource "aws_iam_policy" "s3-jenkins-policy" {
  name = "s3-jenkins-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "S3Access"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          "${aws_s3_bucket.jenkins-bucket.arn}/*",
          "${aws_s3_bucket.jenkins-bucket.arn}"
        ]
      }
    ]
  })
}

#Attaches IAM policy to IAM role
resource "aws_iam_role_policy_attachment" "s3-jenkins-policy-attachment" {
  policy_arn = aws_iam_policy.s3-jenkins-policy.arn
  role       = aws_iam_role.s3-jenkins-role.name
}