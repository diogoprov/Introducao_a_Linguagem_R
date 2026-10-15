# Roda quando a lição começa (e de novo se o aluno retomar).
# Prepara os três recortes da lição: todos os animais com CTmax medido,
# só os sapos-cururus (regressão) e duas espécies (teste t).

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) file.path(find.package("swirl"), "Courses"))
}

.bruto <- read.csv(file.path(.get_course_path(), "Introducao_a_Linguagem_R",
                             "Testes_como_Modelos_Lineares", "anuros_altitude.csv"))
.bruto <- .bruto[!is.na(.bruto$CTmax), ]

anuros <- data.frame(
  especie  = .bruto$Species,
  serra    = .bruto$Mountain_Range,
  altitude = .bruto$Altitude_m,
  ctmax    = .bruto$CTmax
)

rhinella <- anuros[anuros$especie == "Rhinella icterica", ]
duas     <- anuros[anuros$especie %in% c("Boana faber", "Rhinella icterica"), ]
