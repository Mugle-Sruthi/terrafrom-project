#steps related to terraform project 

#pre-requisite steps to set up Terraform on Fedora before starting a project:

 1. Update Fedora System

--> sudo dnf update -y

2. Install Terraform
Option A: Use HashiCorp’s official repo (recommended)
Add the HashiCorp repo

'''
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

'''

    2. Install Terraform
    
    --> sudo dnf install terraform -y
    3. Verify Installation
    
    --> terraform -version

3. Install AWS CLI (if using AWS provider)
'''
sudo dnf install awscli -y
aws --version
'''

4. Configure AWS Credentials
 -->aws configure

You'll need to enter:

AWS Access Key ID

AWS Secret Access Key

Default region (like us-east-1)

Output format (json is default)


5. Create Your Terraform Project Directory

mkdir my-terraform-project
cd my-terraform-project

6. Initialize Terraform
After writing your .tf files (like main.tf, variables.tf, etc.), run:
terraform init

7. Optional Tools for Ease
Visual Studio Code (for editing .tf files)

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

sudo dnf install code



===========================================================================================================================================================================================================
✅ How to Enable Programmatic Access & Get Access Keys (Step-by-Step)
Sign in to the AWS Console with your IAM user credentials.

In the top search bar, type IAM and click IAM to open the service.

In the left sidebar, click on Users.

Click on your IAM username (e.g., terraform-user).

Now, click the "Security credentials" tab (⚠️ not "Permissions" or "Groups").

Scroll down to Access keys section.

If no access keys are listed, click Create access key.

For "Use case", select:

"Application running outside AWS"

Click Next and then Create access key.

✅ You will now see your:

Access key ID

Secret access key

⚠️ Important: Copy and save these somewhere safe. You won’t be able to see the secret key again.

After that: Run aws configure in your terminal and paste them in.
Let me know if you want help creating a basic Terraform file to launch EC2 instances!


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
* The terminal asks for Access Key & Secret Key when you run:

aws configure

* This command is part of the AWS CLI, and it prompts you like this:

AWS Access Key ID [None]: YOUR_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_SECRET_ACCESS_KEY
Default region name [None]: us-east-1
Default output format [None]: json

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
* History of commands that I used in My project 

sudo rpm --import https://rpm.releases.hashicorp.com/gpg
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo nano /etc/yum.repos.d/hashicorp.repo
sudo dnf install terraform
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/ 
terraform -v
sudo dnf install terraform
mkdir terraform-ec2-project
cd terraform-ec2-project
aws configure
terraform init
terraform plan
terraform apply






