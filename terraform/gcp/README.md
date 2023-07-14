# terraform-gcp
sandbox for terraform tests on GCP

to retrieve credentials files on GCP:
Go on Gcloud Console
In your project, go into IAM > Service accounts
Create one if needed, then go to keys.
Create new key, JSON format and put in this directory
Add \*.json to .gitignore

create terraform.tfvars file with content :

project = "<gcloud project name>"
credentials_file = "<downloaded json file>"

