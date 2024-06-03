include .env

ifndef ENV
ENV=dev
endif

ifeq ($(ENV),dev)
SSH_PORT=22
endif

ifeq ($(ENV),prod)
SSH_PORT=22
endif

push:
	ssh -o StrictHostKeyChecking=no -p $(SSH_PORT) $(SSH_USER)@$(SSH_HOST) "sudo rm -rf $(APP_PATH) && sudo mkdir -p $(APP_PATH)"
	scp -o StrictHostKeyChecking=no -P $(SSH_PORT) -r $(APP_FILES) $(SSH_USER)@$(SSH_HOST):$(APP_PATH)
	ssh -o StrictHostKeyChecking=no -p $(SSH_PORT) $(SSH_USER)@$(SSH_HOST) "cd $(APP_PATH) \
		&& sudo npm i && sudo systemctl restart whatsup-socket"