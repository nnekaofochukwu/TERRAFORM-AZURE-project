# TERRAFORM-AZURE

# TASK OVERVIEW:

In this task, you will design and provision a detailed infrastructure setup using Terraform. 

This includes creating four backend servers, two frontend servers, setting up networking components such as security groups, internet gateway, VPC, subnet, and an S3 bucket. 

Additionally, you will create an IAM user named "BOB" with the description "CTO," and finally, you will initialize a Git repository, commit your Terraform configurations, and share the Git URL.


# INSTRUCTIONS:


1. # DEFINE VARIABLES:

Create a variables.tf file to define variables for your infrastructure setup. 

Include variables for virtual machine types, availability zones, region, CIDR blocks, S3 bucket name, IAM user name, and any other parameters you may need.

Create a terraform.tfvars file to set the values for these variables. 

Make sure to include sensitive information like access keys and secret keys in a separate .gitignore file to avoid accidental Exposure.



2. # SET UP NETWORKING COMPONENTS :

Define a Virtual Private Cloud (VPC) using Terraform and specify the CIDR block.

Create a public subnet within the VPC that spans at least two availability zones.

Set up an internet gateway and attach it to the VPC to enable internet access for resources within the VPC.

Configure a security group to control inbound and outbound traffic for your servers. Allow HTTP/HTTPS traffic for frontend servers and SSH access for backend servers.



3. # PROVISION BACKEND SERVERS : (use tags)

Define Terraform resources for the backend servers. 

Use the specified virtual machine types and number of virtual machines.

Associate the backend servers with the previously created subnet and security group.

Ensure that each backend server has appropriate tags for identification and organization.


4. # PROVISION FRONTEND SERVERS : (use tags)

Define Terraform resources for the frontend servers. 

Use the specified virtual machine types and number of virtual machines.

Associate the frontend servers with the same subnet and security group as the backend servers.

Apply appropriate tags to distinguish frontend servers from backend servers.


5. # SET UP S3 BUCKETS :

Create an S3 bucket using Terraform with a unique name.

Implement any necessary bucket policies or access controls as per your requirements.

Document the purpose and configuration of the S3 bucket in your documentation.


6. # CREATE IAM USER :

Define a Terraform resource for creating an IAM user named "BOB."

Set the description of the user to "CTO."

Ensure that appropriate permissions are assigned to the IAM user based on your organization's policies.

Document the IAM user creation process and the assigned permissions in your documentation.



7. # INITIALIZE GIT AND PUSH TO GIT :

Initialize a Git repository in your project directory using git init.

Add all Terraform configuration files to the repository using git add ..

Commit the changes to the repository using git commit -m "Initial commit".

Create a remote repository on a Git hosting service like GitHub, GitLab, or Bitbucket.

Add the remote repository URL using git remote add origin <remote_repository_url>.

Push the commits to the remote repository using git push -u origin master.
