# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.
# A regra é testar o RESULTADO, não a forma de escrever.

# A expressão usa pelo menos uma das funções listadas.
usa <- function(...) {
  e <- get("e", parent.frame())
  any(c(...) %in% all.names(e$expr))
}

# O valor digitado é igual ao da expressão dada, calculada aqui.
mesmo_valor <- function(expr) {
  e <- get("e", parent.frame())
  alvo <- try(eval(parse(text = expr), globalenv()), silent = TRUE)
  if (inherits(alvo, "try-error")) return(FALSE)
  isTRUE(all.equal(e$val, alvo, check.attributes = FALSE))
}

# 'nome' é uma função e devolve, para os valores de teste, o mesmo que
# a função de referência escrita em 'referencia'.
funcao_equivale <- function(nome, referencia, teste = "anuros$ctmax") {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  f <- get(nome, envir = globalenv())
  if (!is.function(f)) return(FALSE)
  ref <- eval(parse(text = referencia), globalenv())
  x   <- eval(parse(text = teste), globalenv())
  obtido   <- try(f(x), silent = TRUE)
  esperado <- try(ref(x), silent = TRUE)
  if (inherits(obtido, "try-error") || inherits(esperado, "try-error")) return(FALSE)
  isTRUE(all.equal(unname(obtido), unname(esperado), check.attributes = FALSE))
}

# 'nome' é uma lista de modelos lm, um por nível da variável dada.
lista_de_modelos <- function(nome, n) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  m <- get(nome, envir = globalenv())
  is.list(m) && length(m) == n && all(vapply(m, inherits, logical(1), "lm"))
}

# A função 'troca' foi criada e devolve 999, sem alterar o objeto de fora.
funcao_troca <- function() {
  if (!exists("troca", envir = globalenv())) return(FALSE)
  f <- get("troca", envir = globalenv())
  is.function(f) && isTRUE(all.equal(unname(f(10)), 999))
}
