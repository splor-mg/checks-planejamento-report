# Relatório checks planejamento

Para gerar o relatório de validação localmente usando o Docker execute

```bash
docker build --tag checks-planejamento .
docker run -it --rm --mount type=bind,source=${PWD},target=/project checks-planejamento bash
```
e posteriormente

```bash
make all
```
