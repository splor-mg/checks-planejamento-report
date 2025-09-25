.PHONY: all check clean excel zip

DATAPACKAGES := $(wildcard datapackages/*/datapackage.json)

all: clean extract check

extract:
	dpm install

check:
	Rscript scripts/check.R

clean:
	rm -f checks-planejamento.jsonl checks-planejamento.csv
	rm -f checks-planejamento-resumo.csv
	rm -rf datapackages/*
	rm -rf data-results/*/*.xlsx

excel:
	@for dp in $(DATAPACKAGES); do \
	    echo "Processing $$dp"; \
	    python3 -c "from scripts.transform import transform_resource; transform_resource('$$dp')"; \
	done

zip:
	zip -r "$$(date +%Y%m%d%H%M%S)_all_excels.zip" data -i "*.xlsx"
