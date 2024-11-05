SHELL := /bin/bash
PATH_SRC := ankiwordfreq
PATH_VENDORS := $(PATH_SRC)/vendors
ANKI_ADDON_PATH_WIN := C:/Users/$(USER)/AppData/Roaming/Anki2/addons21/ankiwordfreq
ANKI_ADDON_PATH_LINUX := $$HOME/.local/share/Anki2/addons21/ankiwordfreq
ANKI_ADDON_PATH_MACOS := $$HOME/Library/Application\ Support/Anki2/addons21/ankiwordfreq
PYTHON_TAG := $(shell python3 -c "import sysconfig; print(f'cp{sysconfig.get_config_var(\"py_version_nodot\")}')")

ifeq ($(shell uname), Linux)
    ANKI_ADDON_PATH := $(ANKI_ADDON_PATH_LINUX)
else ifeq ($(shell uname), Darwin)
	ANKI_ADDON_PATH := $(ANKI_ADDON_PATH_MACOS)
else
    ANKI_ADDON_PATH := $(ANKI_ADDON_PATH_WIN)
endif


TOP_DEPS := wordfreq
PLATFORMS := win_amd64 manylinux2014_x86_64 macosx_10_13_x86_64
CALL_GFD := "scripts/get_full_deps.sh"
CALL_MV := "scripts/make_vendor.sh"
CALL_FMD := "scripts/fix_mecab_dll.sh"


all:
	mkdir -p dist && \
	$(MAKE) vendors && \
	FILE=$$(poetry version | tr ' ' '_')_$(PYTHON_TAG).ankiaddon && \
	cd $(PATH_SRC) && zip -q -r ../dist/$$FILE *

.PHONY: cjk
cjk:
	mkdir -p dist && \
	$(MAKE) vendors && \
	FILE=$$(poetry version | tr ' ' '_')_cjk_$(PYTHON_TAG).ankiaddon && \
	cd $(PATH_SRC) && zip -q -r ../dist/$$FILE *



.PHONY: vendors
vendors:
	rm -rf $(PATH_VENDORS) && mkdir -p $(PATH_VENDORS) && \
	DEPS=$$($(CALL_GFD) $(TOP_DEPS)) && \
	for dep in $$DEPS; do \
		echo -e "\n\n" && \
		$(CALL_MV) $(PATH_VENDORS) "$$dep" $(PLATFORMS); \
	done && \
	$(CALL_FMD) $(PATH_VENDORS)



.PHONY: link
link:
	$(MAKE) unlink
	ln -s -f $(PWD)/$(PATH_SRC) $(ANKI_ADDON_PATH)

.PHONY: unlink
unlink:
	rm -rf $(ANKI_ADDON_PATH)