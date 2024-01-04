.PHONY: all render

all: extract render

extract:
	dpm install

render: docs/index.html

docs/index.html: report.Rmd
	Rscript -e "rmarkdown::render('$<', output_file = 'index.html', output_dir = 'docs')"
