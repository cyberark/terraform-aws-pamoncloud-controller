{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowEC2RequiredPerms",
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus",
        "ec2:DescribeInstanceTypeOfferings",
        "ec2:RunInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances",
        "ec2:DescribeImages",
        "ec2:CreateImage",
        "ec2:CopyImage",
        "ec2:ModifyImageAttribute",
        "ec2:DeregisterImage",
        "ec2:DescribeSnapshots",
        "ec2:CreateSnapshot",
        "ec2:ModifySnapshotAttribute",
        "ec2:DeleteSnapshot",
        "ec2:DescribeTags",
        "ec2:CreateTags",
        "ec2:DescribeRegions",
        "ec2:DescribeVpcs",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:CreateSecurityGroup",
        "ec2:DeleteSecurityGroup",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateKeyPair",
        "ec2:DeleteKeyPair",
        "ec2:DescribeVolumes",
        "ec2:CreateVolume",
        "ec2:DeleteVolume",
        "ec2:GetPasswordData",
        "ec2:DescribeAvailabilityZones"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowKMSRequiredPerms",
      "Effect": "Allow",
      "Action": [
        "kms:ReEncryptTo",
        "kms:ReEncryptFrom",
        "kms:GenerateDataKey*",
        "kms:CreateGrant",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowS3Read",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:${partition}:s3:::${s3_bucket_name}/${s3_file_name}"
    }
  ]
}
