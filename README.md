# Introdução à Linguagem R — lições interativas no swirl

Lições em português para o pacote [swirl](https://swirlstats.com), que ensina
R dentro do próprio console. Acompanham a disciplina
[Introdução à Linguagem R](https://provetelab.org/intro-r/) (PPGEC/UFMS) e usam
o mesmo conjunto de dados das aulas práticas (anuros ao longo de gradientes
altitudinais na Mata Atlântica; Bovo et al. 2023, *Integrative Organismal
Biology* 5: obad009).

| Lição | Aula | Conteúdo |
|---|---|---|
| Primeiros Passos | 01 | R como calculadora, atribuição, coerção, `read.csv()`, `head()`/`dim()`/`str()`/`summary()`, `table()`, NAs, pacotes |

## Para alunos: como fazer

```r
install.packages("swirl")        # uma vez só
library(swirl)
select_language("portuguese")    # menus do swirl em português (uma vez só)
install_course_github("diogoprov", "Introducao_a_Linguagem_R", branch = "main")
swirl()
```

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
