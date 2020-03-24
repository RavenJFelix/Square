ALL_FILEZ = $(shell find .)
build/index.html:  $(ALL_FILEZ)
	-mkdir build
	rm build/*
	godot --export-debug "HTML5" $@
	zip -v build/ahhh.zip build/* -x $@
