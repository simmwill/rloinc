# Utils

loinc_url <- "http://loinc.org"
base_url <- "https://fhir.loinc.org/"

make_resource <- function(resource){paste0(resource, "/")}
make_operation <- function(op){paste0("$", op)}
make_code <- function(code){paste0("&code=", code)}
make_property <- function(arg){paste0("&&property=", arg)}

make_query <- function(resource, operation, code, params = NULL){

  query <- paste0(base_url,
                  make_resource(resource),
                  make_operation(operation),
                  "?system=",
                  loinc_url,
                  make_code(code),
                  paste0(
                    lapply(params,
                           make_property),
                    collapse = ""))

  query

}
