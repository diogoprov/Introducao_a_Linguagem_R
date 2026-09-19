# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.
# A regra é testar o RESULTADO, não a forma de escrever.

# A expressão usa pelo menos uma das funções listadas.
usa <- function(...) {
  e <- get("e", parent.frame())
  any(c(...) %in% all.names(e$expr))
}

# O data frame 'coleta' já está com os nomes limpos.
nomes_trocados <- function() {
  if (!exists("coleta", envir = globalenv())) return(FALSE)
  identical(names(get("coleta", envir = globalenv())),
            get("nomes_novos", envir = globalenv()))
}

# O valor digitado é igual ao da expressão dada, calculada aqui.
mesmo_valor <- function(expr) {
  e <- get("e", parent.frame())
  alvo <- try(eval(parse(text = expr), globalenv()), silent = TRUE)
  if (inherits(alvo, "try-error")) return(FALSE)
  isTRUE(all.equal(e$val, alvo, check.attributes = FALSE))
}
