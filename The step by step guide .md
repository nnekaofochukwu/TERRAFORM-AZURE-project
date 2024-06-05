# A step by step guide

set up your providers.tf file - The provider.tf file in Terraform is where you declare the providers that a Terraform configuration requires. 
These providers are plugins that Terraform uses to manage resources, and each provider adds a set of data sources and resource types that Terraform can manage. 
Without providers, Terraform can't manage infrastructure.

set up your main.tf file - the main.tf file is the primary configuration file that contains the resource blocks that define the resources to be created in the target cloud platform. 
It's the primary entrypoint for a module, and for a simple module, it may be where all the resources are created.

set up your variables.tf file - for the declaration of variables, name, type, description, default values and additional meta data. 
let you customize aspects of Terraform modules without altering the module's own source code. 
This functionality allows you to share modules across different Terraform configurations, making your module composable and reusable

set up you terraform.tfvars file - allows you to define variable files called *. tfvars to create a reusable file for all the variables for a project.

# Create an Azure AD Application (Service Principal)
Sign in to the Azure Portal:

Navigate to the Azure Portal at portal.azure.com.

Register a New Application:
In the left-hand menu, select "Azure Active Directory."
Under "Manage," click on "App registrations."
Click the "New registration" button.
Provide a name for the application (e.g., "Terraform Service Principal").
Choose the supported account types (usually "Accounts in this organizational directory only" for single tenant).
Click "Register." 
add your main user as the owner of the application you just registered..you wll find the details on the left side of the page.
create a group in the groups page and add your main user as the owner .
add your main user and the registered application/ service principal to the group
make the main user the owner of your group so that the whole group can inherit its permissions too.
go to the IAM page found under your subscriptions page and assign your main user (who is the group owner) owner priviledged administrator roles

# Create a Client Secret:
After the application is registered, navigate to the "Certificates & secrets" section.
Click "New client secret."
Add a description (e.g., "Terraform secret") and choose an expiry period.
Click "Add."
Copy the client secret value immediately and store it securely. You will need this later and won't be able to view it again.
Get the Client ID and Tenant ID:

Go to the "Overview" section of your app registration.
Copy the "Application (client) ID" (Client ID) and "Directory (tenant) ID" (Tenant ID).

# Assign Permissions to the Service Principal
Navigate to the Subscription:

In the left-hand menu, click on "Subscriptions."
Select the subscription you want to use with Terraform.
Assign a Role:

Click on "Access control (IAM)" in the subscription menu.
Click "Add" and then "Add role assignment."
Choose the appropriate role for your Terraform operations (typically "Owner or Contributor" for full access or a more restricted role if needed).
Click "Next."
Under "Assign access to," select "User, group, or service principal."
Search for the name of your registered application.
Select the application and click "Save."

# Configure Terraform with the Service Principal
In your Terraform configuration, you will use the client ID, client secret, tenant ID, and subscription ID to authenticate.

Here is an example of how to configure the provider in your Terraform code:

hcl
Copy code
provider "azurerm" {
  features {}

  subscription_id = "your_subscription_id"
  client_id       = "your_client_id"
  client_secret   = "your_client_secret"
  tenant_id       = "your_tenant_id"
}
Replace the placeholders (your_subscription_id, your_client_id, your_client_secret, your_tenant_id) with the actual values you obtained from the Azure Portal.

# Summary of Required Information:
Client ID: Application (client) ID from Azure AD application registration.
Client Secret: The secret you created and copied.
Tenant ID: Directory (tenant) ID from Azure AD application registration.
Subscription ID: The ID of the subscription you are working with.

and save them in your configured terraform.tfvars file (also remember to set up their variable blocks in the variable.tf file)
By following these steps, you will have successfully created an access key and secret for use with Terraform on Azure. Ensure that you store the secret securely and follow best practices for managing credentials. 

set up your service principal by registering an application (adding an application) under microsoft entra ID.
also do create your client secrets ID and copy and save it in another document IMMEDIATELY before leaving the page.

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
