# Roda uma vez, quando a lição começa (e de novo se o aluno retomar).
# Tudo o que for criado aqui aparece no ambiente global do aluno.

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) file.path(find.package("swirl"), "Courses"))
}

.pasta <- file.path(.get_course_path(), "Introducao_a_Linguagem_R",
                    "Curadoria_de_Dados")

# A planilha ruim da aula, exportada para csv exatamente como está.
arquivo_ruim <- file.path(.pasta, "planilha_ruim.csv")

# As linhas cruas do arquivo, antes de qualquer leitura esperta.
linhas <- readLines(arquivo_ruim)

# A mesma planilha lida pulando as quatro primeiras linhas.
coleta <- read.csv(arquivo_ruim, skip = 4)

# Nomes limpos, para usar mais adiante na lição.
nomes_novos <- c("ponto", "data", "especie", "n_ind", "crc",
                 "massa", "temp", "sexo", "obs", "x1", "x2", "x3")

# O contraponto: o arquivo publicado da disciplina.
dados <- read.csv(file.path(.pasta, "anuros_altitude.csv"))
