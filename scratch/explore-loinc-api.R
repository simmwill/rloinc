# exploring LOINC API

library(curl)
library(httr)
library(rvest)

loinc_url <- "http://loinc.org/"
base_url <- "https://fhir.loinc.org/"
end <- "CodeSystem/"  # ValueSet, ConceptMap, Questionnaire
operation <- "$lookup"
op_details <- c("?system=http://loinc.org", "&code=4544-3")

make_operation <- function(op){paste0("$", op)}
make_code <- function(code){paste0("&code=", code)}
make_property <- function(arg){paste0("&&property=", arg)}
make_codesystem_query <- function(operation, code, params){

  query <- paste0(base_url,
                  "CodeSystem",
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
  # $lookup
  # Returns information about a specific resource, such as a concept (e.g., LOINC term or Part), ValueSet (e.g., LOINC Answer list), or ConceptMap.
  # $expand
  # Returns the set of codes included in a ValueSet.
  # $validate-code
  # Checks to see if a specific code is in a given ValueSet.
  # $translate
  # Use with the ConceptMap resource to find all of the concepts a particular source concept is mapped to.
query <- "4544-3"

call <- paste0(base, end, operation)
# keyring::keyring_create("loinc-api")
# keyring::key_set(service = "loinc-api", username = "wis4002", keyring = "loinc-api")
user <- "wis4002"

# loinc code
results <- GET(url = paste0(base_url, "/CodeSystem/$lookup?system=http://loinc.org&code=4544-3"),
               authenticate(user, keyring::key_get("loinc-api")))

# potentially useful for future

# LOINC <--> SNOMED
"https://fhir.loinc.org/ConceptMap/?url=http://loinc.org/cm/loinc-parts-to-snomed-ct"
"https://fhir.loinc.org/ConceptMap/?url=http://loinc.org/cm/snomed-ct-to-loinc-parts"

# LOINC <--> RxNorm
"https://fhir.loinc.org/ConceptMap/?url=http://loinc.org/cm/loinc-parts-to-rxnorm"
"https://fhir.loinc.org/ConceptMap/?url=http://loinc.org/cm/rxnorm-to-loinc-parts"
