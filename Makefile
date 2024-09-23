.PHONY: all check clean

all: clean extract check

extract:
	dpm install

check: 
	Rscript scripts/check.R

clean: 
	rm -f checks-planejamento.jsonl checks-planejamento.csv
	rm -rf datapackages/*
