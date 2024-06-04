# A step by step guide

# set up your providers.tf file - The provider.tf file in Terraform is where you declare the providers that a Terraform configuration requires. 
These providers are plugins that Terraform uses to manage resources, and each provider adds a set of data sources and resource types that Terraform can manage. 
Without providers, Terraform can't manage infrastructure.

# set up your main.tf file - the main.tf file is the primary configuration file that contains the resource blocks that define the resources to be created in the target cloud platform. 
It's the primary entrypoint for a module, and for a simple module, it may be where all the resources are created.

# set up your variables.tf file - for the declaration of variables, name, type, description, default values and additional meta data. 
let you customize aspects of Terraform modules without altering the module's own source code. 
This functionality allows you to share modules across different Terraform configurations, making your module composable and reusable

# set up you terraform.tfvars file - allows you to define variable files called *. tfvars to create a reusable file for all the variables for a project.

# set up your service principal by registering an application (adding an application) under microsoft entra ID.
also do create your client secrets ID and copy and save it in another document IMMEDIATELY before leaving the page.

# add your main user as the owner of the application you just registered..you wll find the details on the left side of the page.
# create a group in the groups page and add your main user as the owner .
# add your main user and the registered application/ service principal to the group
# go to the IAM page found under your subscriptions page and assign your main user (who is the group owner) owner priviledged administrator roles
# so that the whole group can inherit the permissions too.

# copy the client secrets ID (ONLY COPIED IMMEDIATELY AFTER THE CREATION OF A SECRETS from the certificate and secrets page )
# copy the client ID ( from the certificate and secrets page)
# copy the subscription ID (from the azure subscriptions page)
# copy the tenant ID ( from the microsoft entra ID page)
# and save them in your configured terraform.tfvars file (also remember to set up their variable blocks in the variable.tf file)

# connect your pc to your azure account - download and install AZURE CLI for your pc and to verify it is working 
# run - az login
and follow its instructions to connect your pc to your azure account/console.


after setting up your files and inputing all the data needed then run the following commands -


# Initialize Terraform: Run - terraform init in your project directory to initialize Terraform and download any necessary plugins.

# Plan your Infrastructure: Run - terraform plan to create an execution plan. 
This step is optional but recommended as it shows what Terraform will do when you apply your configuration.

# Validate Configuration: Run - terraform validate to check your Terraform configuration files for syntax errors and other basic issues.

# Apply Configuration: Run - terraform apply to apply the changes specified in your Terraform configuration files to your AZURE account.
This step will prompt you to confirm the changes before applying them.

# Initialize Git Repository: Run - git init in your project directory to initialize a new Git repository.

# Add Remote Repository: Run - git remote add origin <repository_url> to add a remote repository where you want to push your code. 
Replace <repository_url> with the URL of your remote repository.

# Add Files to Git: Run - git add . to stage all the files in your project directory for the commit.

# Commit Changes: Run - git commit -m "aws resource setup using terraform" to commit the staged files with a commit message describing the changes.

# Push Changes to Remote Repository: Run #git push -u origin master to push the committed changes to the remote repository. T
his assumes that you're pushing to the master branch. If you're pushing to a different branch, replace master with the appropriate branch name.

After completing these steps, your Terraform configuration for managing AWS resources will be stored in a Git repository,
allowing you to version control and collaborate on the infrastructure code.
remember to solve or resolve the errors the CLI advises you to so that you can progress and successfully setup your infrastructure.

# to verify if your infrastructure has been created - 
go to your azure account / console and GITHUB account / console check for the the created resources 
after its all done
