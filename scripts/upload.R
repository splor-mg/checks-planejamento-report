library(Microsoft365R)
library(frictionless)
library(cyphr)

get_token <- function() {

  token_list = AzureAuth::list_azure_tokens()

  if (length(token_list) != 0) {
    logger::log_info("A token was found in {AzureAuth::AzureR_dir()}. Using {names(token_list)[1]} for authentication.")
    token = token_list[[1]]
  }

  else {
    logger::log_info("A token was not found in {AzureAuth::AzureR_dir()}. Decrypting 'ms365.rds' for authentication.")
    k_env <- Sys.getenv("MS365_KEY") # Chave privada obtido via secret vindo do Gitgub Actions
    key <- cyphr::key_sodium(sodium::hex2bin(k_env)) # decriptar token
    token <- cyphr::decrypt(readRDS("ms365r.rds"), key)
  }

  token

}

upload_reports_to_sharepoint <- function() {
  site_url <- 'https://cecad365.sharepoint.com/sites/Splor/'
  site <- get_sharepoint_site(site_url = site_url, token = get_token())
  docs <- site$get_drive('Documentos')
  folder <- docs$get_item('General/@dcppn/DCPPN 2026/PPAG e LOA 2026/Conferências de bases_AID/2026/20-01')
  ts <- format(Sys.time(), "%Y%m%d%H%M%S")  # e.g. "20250925_211845"
  remote_name <- paste0(ts, "_reports", ".zip")
  folder$upload('reports.zip', remote_name)
}

upload_reports_to_sharepoint()
