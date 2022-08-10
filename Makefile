apply:
	terraform plan -out out.plan -var-file=./environments/dev.tfvars
	terraform apply "out.plan"

cleanup:
	rm terraform.tfstate
	az group delete -n gitops-demo-dev -y
