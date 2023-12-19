# Makefile

# Variables
DOCKER_COMPOSE = docker compose
DJANGO_CONTAINER = youtube_backend
DOCKER = docker

# Targets and Dependencies
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make run            - Run the Docker containers"
	@echo "  make stop           - Stop the Docker containers"
	@echo "  make logs           - View container logs"
	@echo "  make migrations     - Apply database migrations"
	@echo "  make superuser      - Create a superuser"
	@echo "  make lint           - Run linting checks"
	@echo "  make test           - Run tests"
	@echo "  make clean          - Remove all Docker containers and volumes"
	@echo "  make docker_it      - Run docker in interactive mode"

run:
	$(DOCKER_COMPOSE) up --build

stop:
	$(DOCKER_COMPOSE) down

logs:
	$(DOCKER_COMPOSE) logs -f $(DJANGO_CONTAINER)

migrations:
	$(DOCKER_COMPOSE) exec $(DJANGO_CONTAINER) python manage.py makemigrations
	$(DOCKER_COMPOSE) exec $(DJANGO_CONTAINER) python manage.py migrate

superuser:
	$(DOCKER_COMPOSE) exec $(DJANGO_CONTAINER) python manage.py createsuperuser

lint:
	$(DOCKER_COMPOSE) exec $(DJANGO_CONTAINER) flake8 .

test:
	$(DOCKER_COMPOSE) exec $(DJANGO_CONTAINER) python manage.py test

clean:
	$(DOCKER_COMPOSE) down -v

docker_it:
	$(DOCKER) exec -it $(DJANGO_CONTAINER) sh
