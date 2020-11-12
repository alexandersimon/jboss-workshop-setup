## Prerequisites
- awscli
- Terraform >= v0.12.28


## Building up the infrastructure

#### Step 0 - Initialize the project
```
# creates AWS credentials in ~/.aws
aws configure

# initializes the Terraform project
terraform init
```

#### Step 1 - Create workspaces for all users
```
terraform workspace new tn1
```
- identical infrastructure in different environments can be managed with Terraform workspaces
- each workspace has its own Terraform state
- useful commands:
  - `terraform workspace list` - list all available workspaces
  - `terraform workspace show` - show currently active workspace
  - `terraform workspace select` - change active workspace
  - `terraform workspace delete` - delete a (non-active) workspace

#### Step 2 - Build setup for each user
```
terraform workspace select tn1
terraform plan -out tn1.tfplan
terraform apply tn1.tfplan
```

#### Step 3 - Connect to servers
```
terraform workspace select tn1
terraform output ssh-private-key > tn1-key.pem
chmod 600 tn1-key.pem

ssh -i tn1-key.pem ec2-user@...
```
- for public dns names of instances see Terraform output!

#### Step 4 - Tear down the setup
```
terraform workspace select tn1
terraform destroy
```


## Troubleshooting

#### ssh: Too many authentication failures
Amazon Linux AMI uses the openssh MaxAuthTries default of 6. This means that it will only try 6 different times to
authenticate you. If you hit this limit you will see an error. Connect via `ssh -vvv ...` to see what is happening.

To fix the issue, try using: 
```
ssh -o 'IdentitiesOnly yes' -i ...
```

Alternatively, clear list of known identities from ssh agent:
```
ssh-add -l
ssh-add -D
``` 
