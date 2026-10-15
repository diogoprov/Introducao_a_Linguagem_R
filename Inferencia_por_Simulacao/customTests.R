# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.
# Como quase tudo aqui é sorteio, a regra é testar a FORMA do resultado
# (nome, tamanho, tipo), nunca um valor exato.

# A expressão usa pelo menos uma das funções listadas.
usa <- function(...) {
  e <- get("e", parent.frame())
  any(c(...) %in% all.names(e$expr))
}

# O objeto 'nome' existe e é um vetor numérico ou lógico de tamanho n.
vetor_criado <- function(nome, n) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  x <- get(nome, envir = globalenv())
  (is.numeric(x) || is.logical(x)) && length(x) == n
}

# O objeto 'nome' existe e vale o mesmo que a expressão 'alvo'
# (texto avaliado no ambiente global).
vale <- function(nome, alvo) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  x <- get(nome, envir = globalenv())
  esperado <- eval(parse(text = alvo), envir = globalenv())
  isTRUE(all.equal(unname(x), unname(esperado)))
}

# O valor digitado é uma proporção (um número entre 0 e 1).
eh_proporcao <- function() {
  e <- get("e", parent.frame())
  is.numeric(e$val) && length(e$val) == 1 && e$val >= 0 && e$val <= 1
}
