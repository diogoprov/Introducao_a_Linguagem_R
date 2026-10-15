# Roda quando a lição começa (e de novo se o aluno retomar).
# Prepara a "população" (os animais com CTmax medido), o recorte de duas
# espécies para a permutação e as duas funções auxiliares da lição.

.get_course_path <- function(){
  tryCatch(swirl:::swirl_courses_dir(),
           error = function(c) file.path(find.package("swirl"), "Courses"))
}

.bruto <- read.csv(file.path(.get_course_path(), "Introducao_a_Linguagem_R",
                             "Inferencia_por_Simulacao", "anuros_altitude.csv"))
.bruto <- .bruto[!is.na(.bruto$CTmax), ]

anuros <- data.frame(
  especie = .bruto$Species,
  serra   = .bruto$Mountain_Range,
  ctmax   = .bruto$CTmax
)

# A população da lição: os 190 valores de CTmax.
ctmax <- anuros$ctmax

# Recorte para o teste por permutação. especie fica como texto (e não fator)
# para que tapply() não devolva NA para as espécies que ficaram de fora.
duas <- anuros[anuros$especie %in% c("Boana faber", "Rhinella icterica"), ]

# Repete os passos que o aluno digita à mão: sorteia uma amostra de tamanho n,
# monta o IC de 95% com o multiplicador t e diz se ele contém a média real.
contem_mu <- function(n) {
  amostra  <- sample(ctmax, n)
  ep       <- sd(amostra) / sqrt(n)
  t        <- qt(0.975, df = n - 1)
  inferior <- mean(amostra) - t * ep
  superior <- mean(amostra) + t * ep
  inferior < mean(ctmax) & mean(ctmax) < superior
}

# Uma permutação: embaralha os rótulos de espécie e devolve a diferença
# entre as médias (Rhinella icterica menos Boana faber).
dif_embaralhada <- function() {
  medias <- tapply(duas$ctmax, sample(duas$especie), mean)
  medias[["Rhinella icterica"]] - medias[["Boana faber"]]
}

set.seed(2026)
