# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.
# A regra é testar o RESULTADO, não a forma de escrever.

# A expressão usa pelo menos uma das funções listadas.
usa <- function(...) {
  e <- get("e", parent.frame())
  any(c(...) %in% all.names(e$expr))
}

# O pacote está carregado.
pacote_carregado <- function(pacote) {
  paste0("package:", pacote) %in% search()
}

# O objeto 'nome' é um lm com o mesmo ajuste da fórmula 'formula'
# (aceita os termos em outra ordem, data = em outra posição etc.).
modelo_igual <- function(nome, formula) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  m <- get(nome, envir = globalenv())
  if (!inherits(m, "lm")) return(FALSE)
  d <- get("anuros", envir = globalenv())
  alvo <- lm(as.formula(formula), data = d)
  length(fitted(m)) == length(fitted(alvo)) &&
    isTRUE(all.equal(unname(fitted(m)), unname(fitted(alvo))))
}

# O valor digitado é uma tabela com estas colunas (entre outras).
tabela_com_colunas <- function(colunas) {
  e <- get("e", parent.frame())
  is.data.frame(e$val) && all(strsplit(colunas, ",")[[1]] %in% names(e$val))
}
