STYLESHEET=colony

TARGETS=\
	out/developers.html \
	out/developers_intro.html \
	out/faq.html \
	out/ksy_reference.html \
	out/lang_cpp_stl.html \
	out/lang_java.html \
	out/lang_javascript.html \
	out/lang_php.html \
	out/lang_python.html \
	out/new_language.html \
	out/stream_api.html \
	out/user_guide.html \
	out/ksy_style_guide.html \
	out/index.html

all: $(TARGETS)
	rm -rf out/img
	cp -r img styles js out
	cp raw/coderay-asciidoctor.css out

#out/%.html: raw/%.html tmpl/navbar.html tmpl/footer.html
#	cat tmpl/navbar.html $< tmpl/footer.html >tmp.html
#	mkdir -p out
#	mv tmp.html $@

out/%.html: raw/%.html tmpl/navbar.html postprocess-html
	./postprocess-html $< $@

raw/%.html: %.adoc styles/$(STYLESHEET).css raw/styles/$(STYLESHEET).css
	TZ=UTC asciidoctor -a stylesheet=styles/$(STYLESHEET).css -a linkcss -D raw $<

raw/styles/$(STYLESHEET).css: styles/$(STYLESHEET).css
	mkdir -p raw/styles
	cp $< $@

#styles/colony.css:
#	mkdir -p styles
#	wget -O styles/colony.css http://themes.asciidoctor.org/stylesheets/colony.css

clean:
	rm -rf out
