# tf-nullprovider-with-count
TF skills map 200, TerraForm null provider with count

# Requirements
This repo assumes general knowledge about Terraform for AWS, if not, please get yourself accustomed first by going through [getting started guide](https://learn.hashicorp.com/terraform?track=getting-started#getting-started) . Please also have your AWS credentials prepared in some way, preferably environment variables. See in details here : [Section - Keeping Secrets](https://aws.amazon.com/blogs/apn/terraform-beyond-the-basics-with-aws/)

# Null provider
Null provider (original documentation can be found here: https://www.terraform.io/docs/providers/null/index.html ) in Terraform is a special case. By itself it does nothing except to have the same lifecycle as other providers. But it can be used as a workaround for some tricky situation and help to orchestrate stuff.
> Note: Usage of null provider can make configuration less readable. Apply with care.
~This repo containts demonstration code for the Null provider usage with count

# Todo
- [ ] make and test example for null provider with counter

# Done

- [x] create an intro
