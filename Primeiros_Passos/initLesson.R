# Roda uma vez, quando a lição começa (e de novo se o aluno retomar).
# Tudo o que for criado aqui aparece no ambiente global do aluno.

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) file.path(find.package("swirl"), "Courses"))
}

# Caminho completo até o CSV que vem junto com a lição.
# No RStudio o aluno usará "dados/anuros_altitude.csv"; aqui dentro do
# swirl não sabemos qual é a pasta de trabalho, por isso o caminho pronto.
arquivo <- file.path(.get_course_path(), "Introducao_a_Linguagem_R",
                     "Primeiros_Passos", "anuros_altitude.csv")
