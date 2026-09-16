# Roda quando a lição começa (e de novo se o aluno retomar).
# Tudo o que for criado aqui aparece no ambiente global do aluno.

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) file.path(find.package("swirl"), "Courses"))
}

# Os dados brutos da disciplina, já lidos, como na aula 01.
bruto <- read.csv(file.path(.get_course_path(), "Introducao_a_Linguagem_R",
                            "Manuseio_de_Dados_com_dplyr", "anuros_altitude.csv"))
