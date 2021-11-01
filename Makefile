.PHONY: plan apply destroy

plan:
	terraform plan -var-file=secrets.tfvars -out='infra.out'

apply:
	terraform apply "infra.out"

destroy:
	terraform plan -destroy -var-file=secrets.tfvars -out='infra.out'

recreate: destroy apply plan apply