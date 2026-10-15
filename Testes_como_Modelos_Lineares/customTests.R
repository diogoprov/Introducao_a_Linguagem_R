# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.
# A regra é testar o RESULTADO, não a forma de escrever.

# A expressão usa pelo menos uma das funções listadas.
usa <- function(...) {
  e <- get("e", parent.frame())
  any(c(...) %in% all.names(e$expr))
}

# 'nome' (um objeto, ou uma coluna como 'duas$x') vale o mesmo que a
# expressão 'alvo'.
vale <- function(nome, alvo) {
  x <- tryCatch(eval(parse(text = nome), envir = globalenv()),
                error = function(c) NULL)
  if (is.null(x)) return(FALSE)
  esperado <- eval(parse(text = alvo), envir = globalenv())
  isTRUE(all.equal(unname(as.vector(x)), unname(as.vector(esperado))))
}

# Dois modelos (lm ou glm) com o mesmo ajuste: mesma classe e mesmos
# valores previstos. Aceita termos em outra ordem, data = em outra posição etc.
.mesmo_ajuste <- function(m, alvo) {
  a <- eval(parse(text = alvo), envir = globalenv())
  inherits(m, class(a)[1]) && length(fitted(m)) == length(fitted(a)) &&
    isTRUE(all.equal(unname(fitted(m)), unname(fitted(a))))
}

# O objeto 'nome' é um modelo igual ao da expressão 'alvo'.
modelo_igual <- function(nome, alvo) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  .mesmo_ajuste(get(nome, envir = globalenv()), alvo)
}

# O valor digitado (sem guardar em objeto) é um modelo igual ao de 'alvo'.
ajusta <- function(alvo) {
  e <- get("e", parent.frame())
  .mesmo_ajuste(e$val, alvo)
}

# O valor digitado é um número perto de 'alvo'.
perto <- function(alvo, tol = 0.02) {
  e <- get("e", parent.frame())
  is.numeric(e$val) && length(e$val) == 1 && abs(e$val - alvo) <= tol
}
