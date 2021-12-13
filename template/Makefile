# Pandoc Markdown to PDF document generation Makefile
# 
# Author: Benjamin Legendre 2017

# Variables

SHELL = /bin/sh
BUILDDIR = build
DOCDIR = doc
VPATH = src:$(BUILDDIR)

VERSION = $(shell cat metadata.yml | grep -v -e '^---$$' | yq e '.version' -)

DOC_SOURCE = ../metadata.yml $(shell cat metadata.yml | grep -v -e '^---$$' | yq e '.source_files' -)

DOC_NAME = $(shell cat metadata.yml | grep -v -e '^---$$' | yq e '.output_basename' -)-$(VERSION).pdf

PANDOC = /usr/bin/pandoc
PLANTUML = /usr/bin/plantuml

# Binaries figures 

FIGURES = $(shell find fig -type f -iname "*" | sed 's/fig/build\/fig/g')

# Plant UML diagrams

PUMLSOURCES = $(shell find src -type f -iname "*.puml" | sed 's/src\/puml/build\/fig/g')
PUMLPNGS = $(PUMLSOURCES:.puml=.png)

.PHONY: all clean debug

# Generic Rules

all: $(FIGURES) \
		 $(PUMLPNGS) \
		 $(SVGPNGS) \
     $(DOC_NAME) 

clean:
	rm -rf $(BUILDDIR)

dist: all
	rm -f $(BUILDDIR)/$(DOC_NAME:.pdf=.tar.gz)
	cd $(BUILDDIR) && tar -cf $(DOC_NAME:.pdf=.tar) *
	tar rf $(BUILDDIR)/$(DOC_NAME:.pdf=.tar) ./* \
		--exclude-vcs \
		--exclude="$(BUILDDIR)" \
		--transform="s=^\./=src/="
	gzip $(BUILDDIR)/$(DOC_NAME:.pdf=.tar)

# Deliveries building rules

$(DOC_NAME): $(FIGURES) \
	         $(DOC_SOURCE)
	mkdir -p $(BUILDDIR)
	# Generate document with Pandoc
	cd $(BUILDDIR) && $(PANDOC) -f markdown \
		--number-sections \
		-H ../lib/disable-float.tex \
		--template=../lib/template.tex \
		--variable=template-path:../lib \
		--variable=ref:"$(DOC_REF)" \
		--variable=doc_version:"$(VERSION)" \
		-o $(DOC_NAME) $(addprefix ../src/,$(DOC_SOURCE))
	cd $(BUILDDIR) && $(PANDOC) -f markdown \
		--number-sections \
		-o $(DOC_NAME:.pdf=.docx) $(addprefix ../src/,$(DOC_SOURCE))

# Pattern Rules

build/fig/%.png: src/puml/%.puml
	mkdir -p $(BUILDDIR)/fig
	$(PLANTUML) -tpng $< -o $(shell readlink -f $(BUILDDIR))/fig/

build/fig/%: fig/%
	mkdir -p $(BUILDDIR)/fig
	cp $< $@
