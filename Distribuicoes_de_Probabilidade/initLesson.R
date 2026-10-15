# Roda quando a lição começa (e de novo se o aluno retomar).
# Prepara os animais com CTmax medido e o CTmax dos sapos-cururus.

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) file.path(find.package("swirl"), "Courses"))
}

.bruto <- read.csv(file.path(.get_course_path(), "Introducao_a_Linguagem_R",
                             "Distribuicoes_de_Probabilidade", "anuros_altitude.csv"))
.bruto <- .bruto[!is.na(.bruto$CTmax), ]

anuros <- data.frame(
  especie = .bruto$Species,
  ctmax   = .bruto$CTmax
)

# CTmax dos 47 sapos-cururus (Rhinella icterica).
rhinella <- anuros$ctmax[anuros$especie == "Rhinella icterica"]

set.seed(2026)
