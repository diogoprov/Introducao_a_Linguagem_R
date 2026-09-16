# Roda quando a lição começa (e de novo se o aluno retomar).
# Monta 'anuros' já limpo, como sai do script da aula 04, sem depender
# do arquivo que o aluno gravou naquela aula.

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) file.path(find.package("swirl"), "Courses"))
}

.bruto <- read.csv(file.path(.get_course_path(), "Introducao_a_Linguagem_R",
                             "Modelos_Lineares", "anuros_altitude.csv"))

anuros <- data.frame(
  especie  = factor(.bruto$Species),
  sexo     = factor(.bruto$Sex),
  serra    = factor(.bruto$Mountain_Range),
  altitude = .bruto$Altitude_m,
  massa    = .bruto$Bodymass_g,
  ctmin    = .bruto$CTmin,
  ctmax    = .bruto$CTmax,
  bio5     = .bruto$BIO_5
)
anuros$amplitude <- anuros$ctmax - anuros$ctmin
anuros$tol_aquec <- anuros$ctmax - anuros$bio5
