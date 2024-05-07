SHELL=/bin/bash -e -o pipefail
PWD = $(shell pwd)

lint:
	@docker run --rm -v $(PWD):/work:ro dshanley/vacuum:v0.9.15 lint OpenAPI/v2.yml

install-dependencies:
	@npm i postman-to-openapi -g

convert:
	@p2o ./proximity/v2.json -f ./OpenAPI/v2.yml
	@p2o ./proximity/v1.json -f ./OpenAPI/v1.yml