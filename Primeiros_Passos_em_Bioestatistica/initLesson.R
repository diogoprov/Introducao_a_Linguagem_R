# Roda quando a lição começa (e de novo se o aluno retomar).
# Prepara a tabela anuros com todos os 225 animais, inclusive os 35 sem
# CTmax medido: os NA são de propósito, para a parte do na.rm = TRUE.

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) file.path(find.package("swirl"), "Courses"))
}

.bruto <- read.csv(file.path(.get_course_path(), "Introducao_a_Linguagem_R",
                             "Primeiros_Passos_em_Bioestatistica",
                             "anuros_altitude.csv"))

anuros <- data.frame(
  especie  = .bruto$Species,
  serra    = .bruto$Mountain_Range,
  altitude = .bruto$Altitude_m,
  massa    = .bruto$Bodymass_g,
  ctmax    = .bruto$CTmax
)
