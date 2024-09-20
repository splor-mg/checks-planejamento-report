.PHONY: all check clean

all: clean extract check

extract:
	dpm install

check: 
	Rscript scripts/check.R

clean: 
	rm checks-planejamento.jsonl checks-planejamento.xlsx
	rm -rf datapackages/*
