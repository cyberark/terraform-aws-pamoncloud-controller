# PAMonCloud Controller deployment example

Configuration in this directory creates a controller host to allow you to run the PAMonCloud solution with no further required prerequisites.

## Usage

To run this example you need input the required variables, then execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example creates resources which can cost money (AWS EC2 Instance, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](https://github.com/hashicorp/terraform) | >= 1.9.8, <= 1.13.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](https://github.com/hashicorp/terraform-provider-aws) | 5.73.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_pamoncloud_controller"></a> [pamoncloud_controller](/) | ../../ | n/a |

## Inputs

No inputs.
| Name | Description | Type | Default |
|------|-------------|------|---------|
| <a name="input_allowed_ssh_cidr"></a> [allowed\_ssh\_cidr](#input\_allowed\_ssh\_cidr) | CIDR blocks allowed for SSH inbound access | `list` | `["0.0.0.0/0"]` |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | EC2 key pair name | `string` | `"PAMonCloud-KP"` |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name for the S3 bucket containing the BYOI zip | `string` | n/a |
| <a name="input_s3_file_name"></a> [s3\_file\_name](#input\_s3\_file\_name) | BYOI zip file name to be downloaded from S3 | `string` | `"PAM_Self-Hosted_on_AWS.zip"` |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | Controller instance public IP address. |
| <a name="output_instance_public_dns"></a> [instance\_public\_dns](#output\_instance\_public\_dns) | Controller instance public DNS. |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | Controller instance ID. |

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