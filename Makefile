.DEFAULT_GOAL = help
DOCKER_COMPOSE=@docker compose
DOCKER_EXEC=@docker exec -it

help:
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^## ——)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
.PHONY: help

## —— Docker 🐳  —————————————————————————————————————————————————————
start:	## Lancer les containers docker (en mode dev)
	$(DOCKER_COMPOSE) -f ./deployments/local/compose.yaml up -d
.PHONY: start

stop:	## Arréter les containers docker
	$(DOCKER_COMPOSE) -f ./deployments/local/compose.yaml down
.PHONY: stop

restart: stop start	## redémarrer les containers (en mode dev)
.PHONY: restart

ps: ## Affiche les containers docker
	@docker ps
.PHONY: ps
