# Roda quando a lição começa (e de novo se o aluno retomar).
# Reproduz, em R básico, os dados simulados da aula 02 de Bioestatística
# (R/aula02_amostragem.R e R/aula02_delineamento.R do site da disciplina),
# com as mesmas sementes, para que os números batam com os slides.

# A floresta: 256 parcelas numa grade 16 x 16, com três tipos de solo.
set.seed(21)
.g     <- expand.grid(x = 1:16, y = 1:16)
.ruido <- rnorm(256, 0, .9)
.solo  <- ifelse(.g$x + .35 * .g$y + .ruido < 7.5, "Argiloso",
          ifelse(.g$y + .3 * .g$x + .ruido > 13.5, "Arenoso", "Rochoso"))
floresta <- data.frame(
  x = .g$x, y = .g$y, solo = .solo,
  biomassa = unname(c(Argiloso = 140, Rochoso = 60, Arenoso = 95)[.solo]) +
    rnorm(256, 0, 15)
)

# Amostragem estratificada de 16 parcelas: sorteia dentro de cada solo, em
# número proporcional à área dele, e pondera a média de cada solo pela área.
estratificada <- function() {
  area   <- table(floresta$solo) / nrow(floresta)
  sortear <- c(Arenoso = 5, Argiloso = 4, Rochoso = 7)
  medias <- sapply(names(sortear), function(s)
    mean(sample(floresta$biomassa[floresta$solo == s], sortear[[s]])))
  sum(area[names(sortear)] * medias)
}

# Amostragem sistemática: uma parcela a cada 4, nas duas direções, a partir
# de um ponto inicial sorteado.
sistematica <- function() {
  inicio <- sample(1:4, 2, replace = TRUE)
  mean(floresta$biomassa[(floresta$x - inicio[1]) %% 4 == 0 &
                         (floresta$y - inicio[2]) %% 4 == 0])
}

# O estudo observacional: o nitrogênio NÃO afeta o crescimento; só a água.
set.seed(12)
obs <- data.frame(agua = runif(60, 5, 35))
obs$nitrogenio  <- 1 + .08 * obs$agua + rnorm(60, 0, .35)
obs$crescimento <- .5 + .05 * obs$agua + rnorm(60, 0, .18)
obs$classe_agua <- cut(obs$agua, c(5, 15, 25, 35), include.lowest = TRUE,
                       labels = c("seco", "intermediario", "umido"))

# Tratamentos distribuídos "por conveniência": o controle nas 20 parcelas
# mais secas, o muito nitrogênio nas 20 mais úmidas.
trat_conveniencia <- rep(c("Controle", "Pouco N", "Muito N"),
                         each = 20)[rank(obs$agua)]

# Um estudo com pseudorréplica: uma lagoa por tratamento e 10 girinos de
# cada lagoa tratados como réplicas. Não há efeito nenhum do tratamento;
# as lagoas só diferem entre si por acaso. Devolve o valor-p do teste t.
estudo_pseudo <- function() {
  lagoa <- rnorm(2, 0, .5)
  tratada  <- rnorm(10, lagoa[1], 1)
  controle <- rnorm(10, lagoa[2], 1)
  t.test(tratada, controle)$p.value
}

# O mesmo esforço (20 girinos) com o desenho correto: 10 lagoas por
# tratamento e um girino de cada. Também sem efeito do tratamento.
estudo_lagoas <- function() {
  tratada  <- rnorm(10, 0, .5) + rnorm(10, 0, 1)
  controle <- rnorm(10, 0, .5) + rnorm(10, 0, 1)
  t.test(tratada, controle)$p.value
}

set.seed(2026)
