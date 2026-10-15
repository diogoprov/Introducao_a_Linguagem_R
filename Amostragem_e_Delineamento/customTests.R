# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.
# Onde há sorteio, testa-se a FORMA do resultado (nome, tamanho, faixa),
# nunca um valor exato.

# A expressão usa pelo menos uma das funções listadas.
usa <- function(...) {
  e <- get("e", parent.frame())
  any(c(...) %in% all.names(e$expr))
}

# 'nome' (um objeto, ou uma coluna como 'obs$x') vale o mesmo que a
# expressão 'alvo'.
vale <- function(nome, alvo) {
  x <- tryCatch(eval(parse(text = nome), envir = globalenv()),
                error = function(c) NULL)
  if (is.null(x)) return(FALSE)
  esperado <- eval(parse(text = alvo), envir = globalenv())
  isTRUE(all.equal(unname(as.vector(x)), unname(as.vector(esperado))))
}

# O valor digitado é igual ao da expressão 'alvo', qualquer que seja o
# caminho usado para chegar a ele.
resulta <- function(alvo) {
  e <- get("e", parent.frame())
  esperado <- eval(parse(text = alvo), envir = globalenv())
  !is.null(e$val) && length(e$val) == length(esperado) &&
    isTRUE(all.equal(unname(as.vector(e$val)), unname(as.vector(esperado))))
}

# O objeto 'nome' existe e é um vetor numérico ou lógico de tamanho n.
vetor_criado <- function(nome, n) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  x <- get(nome, envir = globalenv())
  (is.numeric(x) || is.logical(x)) && length(x) == n
}

# O valor digitado é um número entre 'min' e 'max'.
entre <- function(min, max) {
  e <- get("e", parent.frame())
  is.numeric(e$val) && length(e$val) == 1 && e$val >= min && e$val <= max
}

# O objeto 'nome' é um modelo (lm) com o mesmo ajuste da expressão 'alvo'.
modelo_igual <- function(nome, alvo) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  m <- get(nome, envir = globalenv())
  a <- eval(parse(text = alvo), envir = globalenv())
  inherits(m, class(a)[1]) && length(fitted(m)) == length(fitted(a)) &&
    isTRUE(all.equal(unname(fitted(m)), unname(fitted(a))))
}
