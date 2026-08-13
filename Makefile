OUTPUT=_build

html: prepare
	cp -R images $(OUTPUT)/html
	asciidoctor index.adoc -D $(OUTPUT)/html
	asciidoctor iso27005_2022_adaptations.adoc -D $(OUTPUT)/html

pdf: prepare
	asciidoctor -a pdf-style=Monarc-theme.yml \
		-r asciidoctor-pdf -b pdf index.adoc \
		-o $(OUTPUT)/pdf/user-guide.pdf
	asciidoctor -a pdf-style=Monarc-theme.yml \
		-r asciidoctor-pdf -b pdf iso27005_2022_adaptations.adoc \
		-o $(OUTPUT)/pdf/iso27005_2022_adaptations.pdf

prepare:
	mkdir -p $(OUTPUT) $(OUTPUT)/html $(OUTPUT)/pdf

clean:
	rm -Rf $(OUTPUT)

serve:
	"$(shell which xdg-open || which open || which x-www-browser)" \
		http://localhost:8000/$(OUTPUT)/html
	python3 -m http.server 8000
