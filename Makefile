SHELL=/bin/bash -e -o pipefail
PWD = $(shell pwd)

# Lint OpenAPI files
lint-oas:
	@docker run --rm -v $(PWD):/work:ro dshanley/vacuum:v0.9.15 lint OpenAPI/v1.yml
	@docker run --rm -v $(PWD):/work:ro dshanley/vacuum:v0.9.15 lint OpenAPI/v2.yml

# Install dependencies for converting postman files to OpenAPI
install-dependencies:
	@npm install -g postman-to-openapi

# Convert postman files to OpenAPI
convert2openapi:
	@p2o ./proximity/v2.json -f ./OpenAPI/v2.yml
	@p2o ./proximity/v1.json -f ./OpenAPI/v1.yml

# Check for uncommitted git changes
check-git-status:
	@if git diff --quiet && git diff --staged --quiet; then \
		echo "No uncommitted changes detected."; \
	else \
		echo "Error: Uncommitted changes detected." >&2; \
		echo "Run `make convert2openapi` again and push changes!" >&2; \
		exit 1; \
	fi