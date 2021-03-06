BASE_NAME=index
OUTPUT=_build

html: prepare
	cp -R images $(OUTPUT)/html
	asciidoctor *.adoc -D $(OUTPUT)/html

pdf: prepare
	asciidoctor -a pdf-style=Monarc-theme.yml \
		-r asciidoctor-pdf -b pdf *.adoc \
		-o $(OUTPUT)/pdf/user-guide.pdf

prepare:
	mkdir -p $(OUTPUT)

clean:
	rm -Rf $(OUTPUT)

serve:
	"$(shell which xdg-open || which open || which x-www-browser)" \
		http://localhost:8000/$(OUTPUT)/html
	python3 -m http.server 8000
