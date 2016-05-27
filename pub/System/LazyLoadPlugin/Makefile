FOSWIKI_ROOT?=~/foswiki/core
CP=cp
TARGET=\
  jquery.lazyload.js \
  jquery.lazyload.init.js

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include

.PHONY: git

git:
	git clone https://github.com/tuupola/jquery_lazyload.git git

ifneq (,$(wildcard git))
jquery.lazyload.uncompressed.js: git/jquery.lazyload.js
	@echo copying $< to $@ 
	@$(CP) $< $@
endif

clean:
	rm jquery.lazyload.uncompressed.js $(TARGET) *.gz
