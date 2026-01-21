# Relatório checks planejamento


Antes de gerar o relatório, confirme que os datapackages descritos no `data.toml` do projeto contém os endereços para os arquivos `datapackage.yaml` do exercício correto. Também confirme que as rotinas de atualização desses dados foram executadas corretamente, ou seja, que o github actions ou a pipeline de dados (make all) de cada um desses datapackages foram executadas sem erros.

Para gerar o relatório de validação localmente usando o Docker execute:

```bash
docker build --tag checks-planejamento .
docker run -it --rm --mount type=bind,source=${PWD},target=/project checks-planejamento bash
```
e posteriormente

```bash
make all
```

São gerados dois arquivos:

- `data\checks-planejamento.xlsx` contém a lista de erros e um resumo dos erros encontrados.

- `reports.zip` que contém o arquivo `data\checks-planejamento.xlsx` como também os arquivos de dados utilizados para gerá-lo. Útil para verificar a procedência dos dados cujos erros estão apontados no relatório.

