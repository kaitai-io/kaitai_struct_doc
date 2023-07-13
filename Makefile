STYLESHEET=colony

TARGETS=\
	out/svg/two_parents.svg \
	out/svg/ci_overview.svg \
	out/ci.html \
	out/developers.html \
	out/developers_intro.html \
	out/faq.html \
	out/ksy_diagram.html \
	out/lang_cpp_stl.html \
	out/lang_java.html \
	out/lang_javascript.html \
	out/lang_php.html \
	out/lang_python.html \
	out/new_language.html \
	out/serialization.html \
	out/stream_api.html \
	out/user_guide.html \
	out/ksy_style_guide.html \
	out/kst.html \
	out/index.html

all: $(TARGETS)
	cp -r img styles js out
	cp raw/styles/*.css out/styles
	cp "$$(bundle exec ruby -e "require 'asciidoctor'" -e "require 'asciidoctor/tabs'" -e 'puts ::Asciidoctor::Tabs::Docinfo::Style::DEFAULT_STYLESHEET_FILE')" out/styles/asciidoctor-tabs.css
	cp "$$(bundle exec ruby -e "require 'asciidoctor'" -e "require 'asciidoctor/tabs'" -e 'puts ::Asciidoctor::Tabs::Docinfo::Behavior::JAVASCRIPT_FILE')" out/js/asciidoctor-tabs.js
	cp ksy_reference.html out
	cp -r docson/public/docson.js docson/public/lib/ out/js
	cp -r docson/public/templates out
	cp docson/public/css/docson.css out/styles

out/%.html: raw/%.html tmpl/navbar.html postprocess-html
	./postprocess-html $< $@

raw/%.html: %.adoc
	TZ=UTC bundle exec asciidoctor -r asciidoctor-tabs -a stylesheet! -a docinfo=shared,private -a nofooter -a source-highlighter=pygments -a pygments-style=default -a linkcss -a copycss -a stylesdir=styles -a scriptsdir=js -D raw $<

out/svg/%.svg: dot/%.dot
	mkdir -p out/svg
	dot -Tsvg $< -o $@

clean:
	rm -rf out raw
