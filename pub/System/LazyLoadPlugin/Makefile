FOSWIKI_ROOT?=~/foswiki/core
CP=cp
TARGET=\
  jquery.lazyload.js \
  jquery.lazyload.init.js

-include $(FOSWIKI_ROOT)/pub/System/JQueryPlugin/Makefile.include

jquery.lazyload.uncompressed.js: git/jquery.lazyload.js
	@echo copying $< to $@ 
	@$(CP) $< $@

clean:
	rm jquery.lazyload.uncompressed.js $(TARGET) *.gz
