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