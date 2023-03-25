# Obtain an absolute path to the directory of the Makefile.
# Assume the Makefile is in the root of the repository.
REPODIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
UIDGID := $(shell stat -c '%u:%g' ${REPODIR})


##@ Help
.PHONY: help
help: ## Display this help screen
	@awk -v target="$(filter-out $@,$(MAKECMDGOALS))" 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { if (!target || index($$1, target) == 1) printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { getline nextLine; if (!target || index(nextLine, target) == 1) printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


##@ Dev
.PHONY: debug
debug: ## Debug the binary with delve
	@docker run --rm -p 2345:2345 -v ${REPODIR}:/app -w /app ${TEST_IMAGE_FULL_NAME}


include Makefile.docker


# Add this line at the end of the Makefile
%: ;