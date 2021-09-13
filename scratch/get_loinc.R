get_loinc <- function(loinc){

  require(rvest)
  require(httr)

  loinc_url <- paste0("https://loinc.org/", loinc)
  loinc_html <- read_html(loinc_url)

  get_aspect <- function(node,
                         type = c("text", "table")){

    html_obj <- loinc_html %>%
      html_nodes(node)

    if(type == "text"){
      obj_details <- html_obj %>% html_text()
    }

    if(type == "table"){
      obj_details <- html_obj %>% html_table()
    }

    obj_details

  }

  # long common name
  lcn <- get_aspect("#lcn", type = "text")

  # status
  status <- get_aspect(".status", type = "text")

  # for future development
  # # component
  # get_aspect("#fully-specified", type = "text") %>%
  #   str_remove_all(c("\n\t\t\t")) %>%
  #   str_remove("Fully-Specified Name")

  results <- list(code = loinc,
                  name = lcn,
                  status = status
  )

  results

}
