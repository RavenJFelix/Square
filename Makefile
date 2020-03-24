ALL_FILEZ = $(shell find .)
build/index.html:  $(ALL_FILEZ)
	-mkdir build
	godot --export "HTML5" $@
	zip build/ahhh.zip * -x $@
