ifeq ($(TEST), true)
CONFFILE := secrets-test.tfvars
STATEFILE := test.out
else
CONFFILE := secrets.tfvars
STATEFILE := infra.out
endif

.PHONY: plan apply destroy

plan:
	terraform plan -var-file=$(CONFFILE) -out=$(STATEFILE)

apply:
	terraform apply $(STATEFILE)

destroy:
	terraform plan -destroy -var-file=$(CONFFILE) -out=$(STATEFILE)

recreate: destroy apply plan apply