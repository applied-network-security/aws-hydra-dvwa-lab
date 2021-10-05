# The Terraform AWS Hydra Lab Build

## Step 0: Launch AWS Academy and log into cloud9

## Step 1: Generata your secure keys

* Log into your cloud9 instances
* Note this will generate ed25519 and rsa key (rsa is for windows)
* These keys are what you will use to log into the machines from your cloud9 box
* To get windows password you will need to the private key located ~/.ssh/id_rsa


```
ssh-keygen -t ed25519 -C "your_email@example.com"
ssh-keygen -t rsa -C "your_email@example.com"
```


### Step 2: Pull the Repo to your Cloud9 instance 
Perform a git clone


```
git clone https://github.com/applied-network-security/aws-hydra-dvwa-lab.git
```


### Step 3: Edit some variables
If you log into cd terraform you will see a terraform.tfvars file edi this file and insert your public ipv4

### Step 4: Install terraform in Cloud9
```
sudo yum install terraform -y
```

### Step 4: Edit the terraform.tfvars 
Add your local ip (optional)

### Step 5: Launch: Perform Terraform Init/Plan and Apply

terraform init: The terraform init command is used to initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.


```
terraform init
```

The terraform plan command creates an execution plan. By default, creating a plan consists of: Reading the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date. Comparing the current configuration to the prior state and noting any differences.

```
terrafrom plan 
```

The terraform apply command executes the actions proposed in a Terraform plan. ... Another way to use terraform apply is to pass it the filename of a saved plan file you created earlier with terraform plan -out=... , in which case Terraform will apply the changes in the plan without any confirmation prompt.

```
terrafrom apply
```

### Step 6: The output
The output will look similar to below, it will allow you to ssh to the servers

bastion_ip = "ssh ec2-user@ec2-18-206-46-176.compute-1.amazonaws.com"




hydra 54.81.183.238 -l admin -P rockyou.txt http-get-form "/vulnerabilities/brute/:username=^USER^&password=^PASS^&Login=Login:F=Username and/or password incorrect.:H=Cookie: security=low; PHPSESSID=aap914245a1besu76ur8i6qvp4"