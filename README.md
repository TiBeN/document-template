My Pandoc/LateX document template 
=================================

Template i use to generate my technical documents in Markdown using Pandoc.

It provides a template dir and a Docker image containing everything is needed
to generate the document in PDF and docx (Pandoc, Latex distribution etc.)

Docker image build
------------------

    $ docker build -t tiben-document-template:1.0 .

Usage
-----

Copy content of `template` directory somewhere and edit the file `metadata.yml`.

Generating the document involves calling Makefile through Docker container. A bash
launcher is available in `bin/` directory:

In the root directory:

    $ cd /path/to/your/template/
    $ /path/to/this/repo/bin/docker-mkdoc [<make targets>]

Without argument, document is rebuilt only if sources are modified.

To force rebuild entire document, use `clean all`:

    $ docker-mkdoc clean all

To create a tar.gz distribution file, use `dist`:

    $ docker-mkdoc dist

This create a tarball containing your built document, figures and sources files.

Template
--------

Metadata of the document are set into the `metadata.yml` Yaml file.  Theses
metadata are merged with Pandoc Yaml metada (properties of this file are
propagated to the Pandoc LateX environment).

The LateX template is stored into `lib/template.tex`.

Cover logo can be changed by overwritting `fig/cover-logo.png`

Input format is Pandoc Markdown (See [Pandoc
manual](https://pandoc.org/MANUAL.html)). Place your markdown files into `src/`
directory, then reference them (in order) into `source_files` property from
`metadata.yml`. 

PlantUML diagram generation
---------------------------

Place your puml file in `template/src/puml` then link your files from `png/` in
your document (see example in default template).
