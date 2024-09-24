Sys.setenv(LOG_FILE = "checks-planejamento.jsonl")

library(data.table)

sigplan <- dpm::read_datapackage("datapackages/sigplan/datapackage.json")
sisor <- dpm::read_datapackage("datapackages/sisor/datapackage.json")
aux <- dpm::read_datapackage("datapackages/auxiliares/datapackage.json")

checks <- checksplanejamento::check_all(
  sigplan$programas_planejamento,
  sigplan$acoes_planejamento,
  sigplan$localizadores_todos_planejamento,
  sigplan$indicadores_planejamento,
  sisor$base_categoria_pessoal,
  sisor$base_detalhamento_obras,
  sisor$base_intra_orcamentaria_detalhamento,
  sisor$base_intra_orcamentaria_repasse,
  sisor$base_limite_cota,
  sisor$base_orcam_despesa_item_fiscal,
  sisor$base_orcam_receita_fiscal,
  sisor$base_orcam_receita_investimento,
  sisor$base_qdd_fiscal,
  sisor$base_qdd_investimento,
  sisor$base_qdd_plurianual,
  sisor$base_qdd_plurianual_invest,
  sisor$base_repasse_recursos,
  aux$desc_setor_governo,
  aux$ffp_acoes,
  output = TRUE
)

logs <- jsonlite::stream_in(file("checks-planejamento.jsonl")) |> data.table::as.data.table()
stopifnot(nrow(checks[valid == FALSE]) == length(unique(logs$type)))
data.table::fwrite(logs[, .(type, timestamp, message, valid)], "checks-planejamento.csv", bom = TRUE, dec = ",", sep = ";")

error_summary <- logs[valid == FALSE, .N, by = type]
setnames(error_summary, old = "N", new = "Número de Erros")
data.table::fwrite(error_summary, "checks-planejamento-resumo.csv", bom = TRUE, dec = ",", sep = ";")