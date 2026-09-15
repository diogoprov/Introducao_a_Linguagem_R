# Testes próprios da lição. Cada função devolve TRUE ou FALSE.
# e$expr = expressão digitada; e$val = valor que ela produziu.

# A variável existe no ambiente global e vale o esperado,
# não importa como o aluno chegou lá (c(1, 2, 3, 4, 5), 1:5, seq(5)...).
var_vale <- function(nome, esperado) {
  if (!exists(nome, envir = globalenv())) return(FALSE)
  isTRUE(all.equal(as.numeric(get(nome, envir = globalenv())),
                   eval(parse(text = esperado)),
                   check.attributes = FALSE))
}

# 'dados' foi lido e tem o formato do arquivo da disciplina.
dados_ok <- function() {
  if (!exists("dados", envir = globalenv())) return(FALSE)
  d <- get("dados", envir = globalenv())
  is.data.frame(d) && nrow(d) == 225 && ncol(d) == 26
}

# Uma tabela de Sex que inclui a contagem de NA.
tabela_sexo_com_na <- function() {
  e <- get("e", parent.frame())
  is.table(e$val) && sum(e$val) == 225 && anyNA(names(e$val))
}
