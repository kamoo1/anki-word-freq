SHELL := /bin/bash
PATH_SRC := ankiwordfreq
PATH_VENDORS := $(PATH_SRC)/vendors
ANKI_ADDON_PATH := C:/Users/$(USER)/AppData/Roaming/Anki2/addons21/ankiwordfreq
TOP_DEPS := wordfreq
PLATFORMS := win_amd64 manylinux2014_x86_64 macosx_10_9_x86_64
CALL_GFD := "scripts/get_full_deps.sh"
CALL_MV := "scripts/make_vendor.sh"
CALL_FMD := "scripts/fix_mecab_dll.sh"


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



.PHONY: vendors
vendors:
	rm -rf $(PATH_VENDORS) && mkdir -p $(PATH_VENDORS) && \
	DEPS=$$($(CALL_GFD) $(TOP_DEPS)) && \
	for dep in $$DEPS; do \
		$(CALL_MV) $(PATH_VENDORS) "$$dep" $(PLATFORMS); \
	done && \
	$(CALL_FMD) $(PATH_VENDORS)



.PHONY: link
link:
	rm -rf $(ANKI_ADDON_PATH)
	ln -s -f $(PWD)/$(PATH_SRC) $(ANKI_ADDON_PATH)
