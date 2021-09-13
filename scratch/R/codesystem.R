# CodeSystem methods

resource <- "CodeSystem"
op <- "lookup"

# define user options that will define params in backend (e.g., parent, child, METHOD_TYP)
  # only for minimally useful set

make_codesystem_query <- function(code, params = NULL){

  make_query(resource, op, code, params)

}
