## Prerequisites
- awscli
- Terraform >= v0.12.28

## Step 0 - Initialize the project
```
# creates AWS credentials in ~/.aws
aws configure

# initializes the Terraform project
terraform init
```

## Step 1 - Create workspaces for all users
```
terraform workspace new tn1
```
- identical infrastructure in different environments can be managed with workspaces in Terraform
- each workspace has its own Terraform state
- useful commands:
  - `terraform workspace list` - list all available workspaces
  - `terraform workspace show` - show currently active workspace
  - `terraform workspace select` - change active workspace
  - `terraform workspace delete` - delete a (non-active) workspace

## Step 2 - Build setup for each user
```
terraform workspace select tn1
terraform plan -out tn1.tfplan
terraform apply tn1.tfplan
```

## Step 3 - Connect to servers
```
terraform workspace select tn1
terraform output ssh-key-pem > tn1-key.pem
chmod 600 tn1-key.pem

ssh -i tn1-key.pem ubuntu@$(terraform output dns-cicd)
ssh -i tn1-key.pem ubuntu@$(terraform output dns-lb)
ssh -i tn1-key.pem ubuntu@$(terraform output dns-jboss-0)
ssh -i tn1-key.pem ubuntu@$(terraform output dns-jboss-1)
ssh -i tn1-key.pem ubuntu@$(terraform output dns-mon)
```

## Step 4 - Tear down the setup
```
terraform workspace select tn1
terraform destroy
```
