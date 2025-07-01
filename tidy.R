library(readr)
a <- read_csv("https://raw.githubusercontent.com/jinseob2kim/R-skku-biohrs/master/data/smc_example1.csv")

## Character: col_character() or "c"
a <- read_csv("https://raw.githubusercontent.com/jinseob2kim/R-skku-biohrs/master/data/smc_example1.csv",col_types = cols(HTN = "c"))

a

class(a)

library(magrittr)

## head(a)
a %>% head

a %>% head(n = 10)

a %>% head(n = 10)
10 %>% head(a, .)
10 %>% head(a, n = .)

## head(subset(a, Sex == "M"))
a %>% subset(Sex == "M") %>% head

b <- subset(a, Sex == "M")
model <- glm(DM ~ Age + Weight + BMI, data = b, family = binomial)
summ.model <- summary(model)
summ.model$coefficients

a %>%
  subset(Sex == "M") %>%
  glm(DM ~ Age + Weight + BMI, data = ., family = binomial) %>%
  summary %>%
  .$coefficients
