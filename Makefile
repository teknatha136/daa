.PHONY: help lint template schema test clean
.DEFAULT_GOAL := help

CHART_NAME := daa
RELEASE_NAME := test-release

## help: Show this help message
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@sed -n 's/^##//p' $(MAKEFILE_LIST) | column -t -s ':' | sed -e 's/^/ /'

## lint: Lint the Helm chart
lint:
	helm lint .

## template: Render templates with test values
template:
	helm template $(RELEASE_NAME) . -f ci/test-values.yaml

## template-debug: Render templates with debug output
template-debug:
	helm template $(RELEASE_NAME) . -f ci/test-values.yaml --debug

## schema: Generate JSON schema from values.yaml using helm-values-schema-json
schema:
	@echo "Generating values.schema.json..."
	@if command -v helm-values-schema-json >/dev/null 2>&1; then \
		helm-values-schema-json -input values.yaml -output values.schema.json; \
		echo "Schema generated successfully."; \
	else \
		echo "Error: helm-values-schema-json not found."; \
		echo "Install it with: go install github.com/losisin/helm-values-schema-json@latest"; \
		exit 1; \
	fi

## schema-check: Verify schema is up to date
schema-check:
	@echo "Checking if schema is up to date..."
	@if command -v helm-values-schema-json >/dev/null 2>&1; then \
		helm-values-schema-json -input values.yaml -output values.schema.json.tmp; \
		if diff -q values.schema.json values.schema.json.tmp >/dev/null 2>&1; then \
			echo "Schema is up to date."; \
			rm -f values.schema.json.tmp; \
		else \
			echo "Schema is out of date. Run 'make schema' to update."; \
			rm -f values.schema.json.tmp; \
			exit 1; \
		fi \
	else \
		echo "Warning: helm-values-schema-json not found, skipping schema check."; \
	fi

## test: Run all tests (lint + template + validate)
test: lint template-validate

## template-validate: Render and validate templates against Kubernetes schemas
template-validate:
	@echo "Rendering and validating templates..."
	@if command -v kubeconform >/dev/null 2>&1; then \
		helm template $(RELEASE_NAME) . -f ci/test-values.yaml | kubeconform -strict -summary -kubernetes-version 1.29.0; \
	else \
		echo "Warning: kubeconform not found, skipping validation."; \
		echo "Install it from: https://github.com/yannh/kubeconform"; \
		helm template $(RELEASE_NAME) . -f ci/test-values.yaml > /dev/null && echo "Template rendering successful."; \
	fi

## install-tools: Install development tools
install-tools:
	@echo "Installing development tools..."
	go install github.com/losisin/helm-values-schema-json@latest
	@echo ""
	@echo "For kubeconform, visit: https://github.com/yannh/kubeconform#installation"
	@echo "  macOS: brew install kubeconform"
	@echo "  Linux: Download from releases page"

## package: Package the Helm chart
package:
	helm package .

## clean: Remove generated files
clean:
	rm -f *.tgz
	rm -f values.schema.json.tmp
