STYLESHEET=colony

TARGETS=\
	out/user_guide.html \
	out/index.html

all: $(TARGETS)
	rm -rf out/img
	cp -r img styles out

#out/%.html: raw/%.html tmpl/navbar.html tmpl/footer.html
#	cat tmpl/navbar.html $< tmpl/footer.html >tmp.html
#	mkdir -p out
#	mv tmp.html $@

out/index.html: raw/index.html tmpl/navbar.html tmpl/footer.html postprocess-html
	./postprocess-html raw/index.html out/index.html
#	cat tmpl/navbar.html raw/index.html tmpl/footer.html >tmp.html
#	mkdir -p out
#	mv tmp.html out/index.html

out/user_guide.html: raw/user_guide.html tmpl/navbar.html tmpl/footer.html postprocess-html
	./postprocess-html raw/user_guide.html out/user_guide.html
#	cat tmpl/navbar.html raw/user_guide.html tmpl/footer.html >tmp.html
#	mkdir -p out
#	mv tmp.html out/user_guide.html

raw/%.html: %.adoc styles/$(STYLESHEET).css raw/styles/$(STYLESHEET).css
	TZ=UTC asciidoctor -a stylesheet=styles/$(STYLESHEET).css -a linkcss -D raw $<
#	asciidoctor --no-header-footer -D raw $<

raw/styles/$(STYLESHEET).css: styles/$(STYLESHEET).css
	mkdir -p raw/styles
	cp $< $@

#styles/colony.css:
#	mkdir -p styles
#	wget -O styles/colony.css http://themes.asciidoctor.org/stylesheets/colony.css

clean:
	rm -rf out
