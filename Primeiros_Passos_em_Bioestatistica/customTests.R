# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.
# A regra é testar o RESULTADO, não a forma de escrever.

# A expressão usa pelo menos uma das funções listadas.
usa <- function(...) {
  e <- get("e", parent.frame())
  any(c(...) %in% all.names(e$expr))
}

# O objeto 'nome' existe e vale o mesmo que a expressão 'alvo'
# (texto avaliado no ambiente global).
vale <- function(nome, alvo) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  x <- get(nome, envir = globalenv())
  esperado <- eval(parse(text = alvo), envir = globalenv())
  isTRUE(all.equal(unname(as.vector(x)), unname(as.vector(esperado))))
}

# O valor digitado é igual ao da expressão 'alvo'. Aceita outro jeito de
# chegar ao mesmo número (40.6 - 28.7 no lugar de max() - min(), por exemplo).
resulta <- function(alvo) {
  e <- get("e", parent.frame())
  esperado <- eval(parse(text = alvo), envir = globalenv())
  !is.null(e$val) && length(e$val) == length(esperado) &&
    isTRUE(all.equal(unname(as.vector(e$val)), unname(as.vector(esperado))))
}
