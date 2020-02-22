STYLESHEET=colony

TARGETS=\
	out/svg/two_parents.svg \
	out/svg/ci_overview.svg \
	out/ci.html \
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
	out/kst.html \
	out/index.html

all: $(TARGETS)
	rm -rf out/img
	cp -r img styles js out
	cp raw/pygments-default.css out/styles

out/%.html: raw/%.html tmpl/navbar.html postprocess-html
	./postprocess-html $< $@

raw/%.html: %.adoc styles/$(STYLESHEET).css raw/styles/$(STYLESHEET).css
	TZ=UTC asciidoctor -a stylesheet=styles/$(STYLESHEET).css -a source-highlighter=pygments -a pygments-style=default -r ./pygments_init.rb -a linkcss -D raw $<

raw/styles/$(STYLESHEET).css: styles/$(STYLESHEET).css
	mkdir -p raw/styles
	cp $< $@

out/svg/%.svg: dot/%.dot
	mkdir -p out/svg
	dot -Tsvg $< -o $@

clean:
	rm -rf out
