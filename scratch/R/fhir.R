# query FHIR API

get_loinc <- function(code, params = NULL, user, password){

  query <- make_codesystem_query(code, params)

  pull <- httr::GET(query, authenticate(user, password, type = "basic"))

  pull_txt <- httr::content(pull, "text") %>% jsonlite::fromJSON(flatten = TRUE)

  pull_txt$parameter$valueString[2]  # just the name

}

