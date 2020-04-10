ALL_FILEZ = $(shell find .)

build/index.html:  $(ALL_FILEZ)
	-mkdir build
	rm -rf build/*
	godot --export "HTML5" $@

kongregate: build/index.html $(ALL_FILEZ)
	zip -jv build/ahhh.zip build/* -x $<

clean:
	rm -rf build/*
