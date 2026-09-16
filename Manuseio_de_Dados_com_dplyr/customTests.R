# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.
#
# A regra aqui é testar o RESULTADO, não a forma de escrever: assim valem
# tanto |> quanto %>%, argumentos em outra ordem, summarize() ou summarise().

# A expressão usa pelo menos uma das funções listadas.
usa <- function(...) {
  e <- get("e", parent.frame())
  any(c(...) %in% all.names(e$expr))
}

# O pacote está carregado.
pacote_carregado <- function(pacote) {
  paste0("package:", pacote) %in% search()
}

# Pega um objeto do ambiente global (ou NULL se não existir).
.pega <- function(nome) {
  if (exists(nome, envir = globalenv())) get(nome, envir = globalenv()) else NULL
}

# Tabela 'nome' tem exatamente estas colunas (em qualquer ordem) e n linhas.
tabela_com <- function(nome, colunas, n = 225) {
  x <- .pega(nome)
  is.data.frame(x) && nrow(x) == n &&
    setequal(names(x), strsplit(colunas, ",")[[1]])
}

# A coluna 'col' de anuros é fator.
coluna_fator <- function(col) {
  x <- .pega("anuros")
  is.data.frame(x) && col %in% names(x) && is.factor(x[[col]])
}

# A coluna 'col' de anuros bate com a conta 'conta' (texto), NA incluídos.
coluna_igual_a <- function(col, conta) {
  x <- .pega("anuros")
  if (!is.data.frame(x) || !col %in% names(x)) return(FALSE)
  esperado <- eval(parse(text = conta), envir = x)
  isTRUE(all.equal(as.numeric(x[[col]]), as.numeric(esperado)))
}

# O valor digitado é a mesma tabela que 'esperado' produz
# (ignora nomes de linha e a diferença entre tibble e data.frame).
tabela_igual_a <- function(esperado) {
  e <- get("e", parent.frame())
  if (!is.data.frame(e$val)) return(FALSE)
  alvo <- eval(parse(text = esperado), envir = globalenv())
  a <- as.data.frame(e$val); b <- as.data.frame(alvo)
  rownames(a) <- NULL; rownames(b) <- NULL
  isTRUE(all.equal(a, b, check.attributes = TRUE))
}

# O valor digitado é o número 'n'.
valor_e <- function(n) {
  e <- get("e", parent.frame())
  is.numeric(e$val) && length(e$val) == 1 && isTRUE(all.equal(e$val, n))
}

# Resumo por espécie: 5 linhas, uma contagem que soma 225 e uma coluna
# com as médias de ctmax calculadas SEM os NA.
resumo_ok <- function() {
  x <- .pega("resumo")
  a <- .pega("anuros")
  if (!is.data.frame(x) || !is.data.frame(a) || nrow(x) != 5) return(FALSE)
  if (!"especie" %in% names(x)) return(FALSE)
  ref <- dplyr::summarise(dplyr::group_by(a, especie),
                          m = mean(ctmax, na.rm = TRUE))
  medias <- ref$m[match(as.character(x$especie), as.character(ref$especie))]
  num <- Filter(is.numeric, as.data.frame(x))
  tem_n <- 225 %in% colSums(num)
  tem_media <- length(Filter(function(v) isTRUE(all.equal(as.numeric(v), medias)), num)) > 0
  tem_n && tem_media
}

# Tabela 'nome' contém estas colunas (entre outras) e tem 'ncol' colunas.
tabela_contem <- function(nome, colunas, ncol) {
  x <- .pega(nome)
  is.data.frame(x) && ncol(x) == ncol &&
    all(strsplit(colunas, ",")[[1]] %in% names(x))
}
