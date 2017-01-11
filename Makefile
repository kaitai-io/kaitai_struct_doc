all: out/user_guide.html
	rm -rf out/img
	cp -r img out

out/user_guide.html: user_guide.adoc stylesheets/colony.css
	asciidoctor -a stylesheet=stylesheets/colony.css -D out user_guide.adoc

stylesheets/colony.css:
	mkdir -p stylesheets
	wget -O stylesheets/colony.css http://themes.asciidoctor.org/stylesheets/colony.css

clean:
	rm -rf out
