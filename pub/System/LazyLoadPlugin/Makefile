FOSWIKI_ROOT?=~/foswiki/core
CP=cp
TARGET=\
  lazysizes.js \
  init.js

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include

.PHONY: git

git:
	git clone https://github.com/aFarkas/lazysizes.git git

ifneq (,$(wildcard git))
lazysizes.uncompressed.js: git/lazysizes.js
	@echo copying $< to $@ 
	@$(CP) $< $@
endif

clean:
	rm -f lazysizes.uncompressed.js $(TARGET) *.gz *.jslint
