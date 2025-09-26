.PHONY: all clean extract check excel zip upload

DATAPACKAGES := $(wildcard datapackages/*/datapackage.json)

all: clean extract check excel zip upload

clean:
	rm -f checks-planejamento.jsonl
	rm -rf datapackages/*
	rm -rf data/*/*.xlsx
	rm -rf data/*.xlsx

extract:
	dpm install

check:
	Rscript scripts/check.R

excel:
	@for dp in $(DATAPACKAGES); do \
	    echo "Processing $$dp"; \
	    python3 -c "from scripts.transform import transform_resource; transform_resource('$$dp')"; \
	done

zip:
	zip -r "reports.zip" data -i "*.xlsx"

upload:
	Rscript scripts/upload.R
