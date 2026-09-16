# Introdução à Linguagem R — lições interativas no swirl

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.22782697.svg)](https://doi.org/10.5281/zenodo.22782697)

Lições em português para o pacote [swirl](https://swirlstats.com), que ensina
R dentro do próprio console. Acompanham a disciplina
[Introdução à Linguagem R](https://provetelab.org/intro-r/) (PPGEC/UFMS) e usam
o mesmo conjunto de dados das aulas práticas (anuros ao longo de gradientes
altitudinais na Mata Atlântica; Bovo et al. 2023, *Integrative Organismal
Biology* 5: obad009).

| Lição | Aula | Conteúdo |
|---|---|---|
| Primeiros Passos | 01 | R como calculadora, atribuição, coerção, `read.csv()`, `head()`/`dim()`/`str()`/`summary()`, `table()`, NAs, pacotes |
| Manuseio de Dados com dplyr | 04 | pipe (`\|>` e `%>%`), `rename()`, `select()`, `mutate()`, `filter()`, `group_by()` + `summarise()`, `count()` |
| Modelos Lineares | 06 | ciclo PPDAC: desenho amostral, exploração, `lm()`, diagnose com `plot()` e `performance`, interpretação com `anova()` e `broom` |

## Para alunos: como fazer

```r
install.packages("swirl")        # uma vez só
library(swirl)
select_language("portuguese")    # menus do swirl em português (uma vez só)
install_course_url("https://github.com/diogoprov/Introducao_a_Linguagem_R/zipball/main")
swirl()
```

Use `install_course_url()` com o endereço acima, e não `install_course_github()`:
esta última monta o endereço com `http://` e pode falhar por tempo esgotado.

Dentro do swirl: `skip()` pula a pergunta, `bye()` sai guardando o progresso,
`main()` volta ao menu.

## Para quem edita

- Cada lição é uma pasta com `lesson.yaml` (as perguntas), `initLesson.R`
  (roda ao abrir a lição) e `customTests.R` (testes de resposta próprios).
- A ordem das lições fica em `MANIFEST`.
- **O nome do repositório precisa ser `Introducao_a_Linguagem_R`.** O
  `install_course_github()` renomeia a pasta instalada com o nome do repositório,
  e o `initLesson.R` usa esse nome para achar o CSV.
- As alternativas das `mult_question` são embaralhadas pelo swirl a cada vez.

Testar localmente sem passar pelo GitHub:

```r
library(swirl)
uninstall_course("Introducao_a_Linguagem_R")   # se já estiver instalado
install_course_directory("~/GitHub/Introducao_a_Linguagem_R")
swirl()
```

## Licença

O conteúdo deste repositório (lições, textos e código) está sob a licença
[Creative Commons Atribuição 4.0 Internacional (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/deed.pt-br).
Texto completo em [`LICENSE`](LICENSE). Ao reutilizar ou adaptar, cite:
Provete, D.B. *Introdução à Linguagem R — lições interativas no swirl*.
Zenodo. <https://doi.org/10.5281/zenodo.22782697>

O arquivo `anuros_altitude.csv` vem do material suplementar de
Bovo, R.P.; Simon, M.N.; Provete, D.B.; Lyra, M.; Navas, C.A.; Andrade, D.V.
(2023). Beyond Janzen's Hypothesis: How Amphibians That Climb Tropical
Mountains Respond to Climate Variation. *Integrative Organismal Biology*
5(1): obad009. <https://doi.org/10.1093/iob/obad009>. O artigo é de acesso
aberto sob licença Creative Commons Atribuição 4.0 (CC BY 4.0), a mesma deste
repositório. O arquivo é redistribuído sem
alterações de conteúdo e deve ser citado pela referência acima.
