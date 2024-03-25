SHELL := /bin/bash
PATH_SRC := ankiwordfreq
PATH_VENDORS := $(PATH_SRC)/vendors
ANKI_ADDON_PATH := C:/Users/$(USER)/AppData/Roaming/Anki2/addons21/ankiwordfreq
TOP_DEPS := wordfreq
PLAT_SPEC_DEPS := msgpack regex mecab-python3
PLATFORMS := win_amd64 manylinux2014_x86_64 macosx_10_9_x86_64


all:
	mkdir -p dist && \
	$(MAKE) vendors && \
	FILE=$$(poetry version | tr ' ' '_').ankiaddon && \
	cd $(PATH_SRC) && zip -r ../dist/$$FILE *

.PHONY: cjk
cjk:
	mkdir -p dist && \
	$(MAKE) vendors && \
	FILE=$$(poetry version | tr ' ' '_')_cjk.ankiaddon && \
	cd $(PATH_SRC) && zip -r ../dist/$$FILE *

# this script recursively finds all dependencies of the top dependencies, and copies them to the vendors directory.
# it also downloads and unpacks platform-specific binary dependencies.
# took me two days bumping my head against a wall trying to figure this out, should have just hardcoded in the first place...

.PHONY: vendors
vendors:
	rm -rf $(PATH_VENDORS) && mkdir -p $(PATH_VENDORS) && \
	PATH_LIB=$$(python -c 'import sys;print(next(filter(lambda s: s.endswith("site-packages"),sys.path)))') && \
	DEPS="" && \
	for dep in $(TOP_DEPS); do DEPS=$$DEPS$$'\n'$$(poetry show -t $$dep | grep -oP "(?<= )[\w-_]+(?= [\>\<\=])"); done && \
	DEPS=$$(python -c 'import sys;from johnnydep import JohnnyDist as JD;from johnnydep.logs import configure_logging as cl;cl(verbosity=0);[print("\n".join(JD(d).import_names)) for d in sys.argv[1:]]' $$DEPS) && \
	DEPS=$$(echo "$$DEPS" | tr -d '\r' | sort | uniq) && \
	DEPS=$$DEPS$$'\n'$$(echo $(TOP_DEPS) | tr ' ' '\n') && \
	(xargs -I{} cp -rf $$PATH_LIB/{} $(PATH_VENDORS)/ <<< "$$DEPS" || true) && \
	VER_PS_DEPS=$$(pip freeze | grep -P "$$(echo $(PLAT_SPEC_DEPS) | tr ' ' '|')") && \
	PARAMS=$$(for platform in $(PLATFORMS); do \
		for dep in $$VER_PS_DEPS; do \
			echo "pip download $$dep --platform $$platform --only-binary=:all: --no-deps -d $(PATH_VENDORS)"; \
		done; \
	done) && \
	(xargs -I{} sh -c '{}' <<< "$$PARAMS" || true) && \
	for whl in $(PATH_VENDORS)/*.whl; do \
		python -c "import zipfile, sys; zipfile.ZipFile(sys.argv[1], 'r').extractall(sys.argv[2])" $$whl $(PATH_VENDORS); \
	done && \
	rm -rf $(PATH_VENDORS)/*.whl $(PATH_VENDORS)/*.dist-info/ $(PATH_VENDORS)/*.libs/ $(PATH_VENDORS)/*.data/


.PHONY: link
link:
	rm -rf $(ANKI_ADDON_PATH)
	ln -s -f $(PWD)/$(PATH_SRC) $(ANKI_ADDON_PATH)
