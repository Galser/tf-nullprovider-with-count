# tf-nullprovider-with-count
TF skills map 200, TerraForm null provider with count

# Requirements
This repo assumes general knowledge about Terraform for AWS, if not, please get yourself accustomed first by going through [getting started guide](https://learn.hashicorp.com/terraform?track=getting-started#getting-started) . Please also have your AWS credentials prepared in some way, preferably environment variables. See in details here : [Section - Keeping Secrets](https://aws.amazon.com/blogs/apn/terraform-beyond-the-basics-with-aws/)

# Null provider
Null provider (original documentation can be found here: https://www.terraform.io/docs/providers/null/index.html ) in Terraform is a special case. By itself it does nothing except to have the same lifecycle as other providers. But it can be used as a workaround for some tricky situation and help to orchestrate stuff.
> Note: Usage of null provider can make configuration less readable. Apply with care.

This repo contains demonstration code for the specific case of Null provider usage with meta-argument [count](https://www.terraform.io/docs/configuration/resources.html#count-multiple-resource-instances-by-count) of Terrafom resource.
To read more in details with description of parameters check also [this link](https://github.com/Galser/tf-null-provider)

- We going to demo usage of **count** and **count.index** in conjunction with null provider. And in this case null provider (**null_resource**) is going to be used exactly as wrapper that executes local-exec to output public IP of every host into a text-file.  Start by creating file [main.tf](main1.tf) with the following content :
    ```terraform
    # Null provider example
    variable "num_instances" {
        default = 3
    }

    # AWS provider
    provider "aws" {
        profile    = "default"
        region     = "eu-central-1"
    }

    resource "aws_instance" "futureweb" {
    count = var.num_instances
    ami           = "ami-048d25c1bda4feda7" # Ubuntu 18.04.3 Bionic, custom
    instance_type = "t2.micro"
        tags = {
            "name" = "futureweb-${count.index}"
        }
    }

    resource "null_resource" "collect_ips_in_file" {
    count = var.num_instances 
    
        provisioner "local-exec" {
            command = "echo ${element(aws_instance.futureweb.*.public_ip, count.index)} >> public_ips.txt"
        }
    }

    ```
- Init Terraform with : 
    ```
    terraform init
    ```
- Now, let's run apply for our code :
    ```
    terraform.apply
    ```
- Output going to look similar to : 
    ```
    aws_instance.futureweb[0]: Creating...
    aws_instance.futureweb[1]: Creating...
    aws_instance.futureweb[2]: Creating...
    ...
    null_resource.collect_ips_in_file[0]: Creation complete after 0s [id=1414239563282542518]
    null_resource.collect_ips_in_file[2]: Creation complete after 0s [id=8254522409250616183]
    null_resource.collect_ips_in_file[1]: Creation complete after 0s [id=8220461059853473850]    
    ```
- Now, remember that we have our `null_resource` , that been executing provider `local-exec`, so , we should have in the current folder file with all public ips. Let's check it, by running : 
    ```
    cat public_ips.txt
    ```
    And the output is :
    ```
    3.122.101.59
    18.185.249.47
    18.197.226.19
    ```
    Sucess!
-  Do not forget to free-up resource, when they do not needed anymore, by running : 
    ```
    terraform destroy
    ```
    And replying `yes` to the question
This concludes the section.

# Todo

# Done

- [x] create an intro
- [x] make and test example for null provider with counter
