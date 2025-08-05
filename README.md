# CyberArk PAMonCloud Controller

## Overview  
Welcome to the **CyberArk PAMonCloud Controller Terraform Module** repository! This project provides a tool to simplify the deployment of **PAMonCloud Controller node**, which includes everything you need in order to run PAMonCloud BYOI on **Amazon Web Services (AWS)**. It consists the required software installed, as well as permissions delegated from an IAM Instance Profile. The controller node is Amazon Linux 2023 based.

## Prerequisites  
Before using these modules, ensure you have the following:  
- **Terraform** installed  
- AWS account with necessary permissions for deploying resources  
- A valid **PAM_Self-Hosted_on_AWS.zip** file containing the BYOI solution  

Instructions for downloading the **PAM_Self-Hosted_on_AWS.zip** file can be found [here](https://docs.cyberark.com/pam-self-hosted/latest/en/content/pas%20cloud/images.htm#CreateyourAMIs). It should be uploaded to an S3 bucket, the deployment will ask for the S3 bucket & names in order to upload it to the controller.

## Usage

Below is an example usage of this Terraform module:

```hcl
module "pamoncloud_controller" {
  source = "cyberark/pamoncloud-controller/aws"

  instance_type     = "m5.xlarge"
  vpc_cidr          = "172.31.0.0/16"
  subnet_cidr       = "172.31.1.0/24"
  allowed_ssh_cidr  = ["3.5.7.9/32", "2.4.6.8/32"]
  key_name          = "my-key"
  s3_bucket_name    = "my-s3-bucket"
  s3_file_name      = "PAM_Self-Hosted_on_AWS.zip"
}
```

## Examples

See [`examples`](/examples) directory for working examples to reference.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](https://github.com/hashicorp/terraform) | 1.9.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](https://github.com/hashicorp/terraform-provider-aws) | 5.73.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type for the controller node | `string` | `"m5.large"` |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `"10.0.0.0/16"` |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | CIDR block for the subnet | `string` | `"10.0.1.0/24"` |
| <a name="input_allowed_ssh_cidr"></a> [allowed\_ssh\_cidr](#input\_allowed\_ssh\_cidr) | CIDR blocks allowed for SSH inbound access | `list` | `["0.0.0.0/0"]` |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | EC2 key pair name | `string` | n/a |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name for the S3 bucket containing the BYOI zip | `string` | n/a |
| <a name="input_s3_file_name"></a> [s3\_file\_name](#input\_s3\_file\_name) | BYOI zip file name to be downloaded from S3 | `string` | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | Controller's instance public IP address. |
| <a name="output_instance_public_dns"></a> [instance\_public\_dns](#output\_instance\_public\_dns) | Controller's instance public DNS. |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | Controller's instance ID. |

## Resources

### Retrieve information about a resource (post deployment)
You can use the `terraform state show` command followed by: `module.<module_name>.<resource_name>`  
Example: `terraform state show 'module.pamoncloud_controller.aws_instance.ec2_instance'`  
For list objects, you can use `terraform state list` to get all objects within the list.

#### **EC2 Instances**
| Resource                              | Description                                    |
|---------------------------------------|------------------------------------------------|
| `aws_instance.ec2_instance`           | Component EC2 instance resource.               |

#### **IAM Resources**
| Resource                                                    | Description                                                 |
|-------------------------------------------------------------|-------------------------------------------------------------|
| `aws_iam_instance_profile.instance_profile`                 | IAM instance profile for the EC2 instance.                  |
| `aws_iam_policy.instance_policy`                            | IAM policy for the EC2 instance.                            |
| `aws_iam_role.instance_role`                                | IAM role for the EC2 instance.                              |
| `aws_iam_role_policy_attachment.instance_policy_attachment` | IAM role policy attachment for the EC2 instance.            |

#### **Networking Resources**
| Resource                                          | Description                                                 |
|---------------------------------------------------|-------------------------------------------------------------|
| `aws_internet_gateway.gw`                         | Internet gateway for the VPC.                               |
| `aws_route_table.public`                          | Route table for the public subnet.                          |
| `aws_route_table_association.public`              | Route table association for the public subnet.              |
| `aws_security_group.instance_sg`                  | Security group for the EC2 instance.                        |
| `aws_subnet.public`                               | Public subnet for the VPC.                                  |
| `aws_vpc.main`                                    | Main VPC for the deployment.                                |

#### **Miscellaneous**
| Resource                                          | Description                                                 |
|---------------------------------------------------|-------------------------------------------------------------|
| `data.aws_ami.latest_amazon_linux`                | Base Amazon Linux AMI used for controller creation.         |
| `data.aws_partition.current`                      | AWS partition data source.                                  |

<!-- END_TF_DOCS -->

## Documentation  
- [Examples](/examples): Ready-to-use examples.  

## Licensing  
This repository is subject to the following licenses:  
- **Terraform templates**: Licensed under the Apache License, Version 2.0 ([LICENSE](LICENSE)).  

## Contributing  
We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for more details.  

## About  
CyberArk is a global leader in **Identity Security**, providing powerful solutions for managing privileged access. Learn more at [www.cyberark.com](https://www.cyberark.com).  