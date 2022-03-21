install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
library(cmdstanr)
cmdstanr::install_cmdstan(dir=file.path("/home/expdes/, ".cmdstanr"))

install.packages(c("janitor", "feather", "patchwork","glmnet","stargazer","corrplot","ggpubr","testthat","sodium","DiagrammeR","rmarkdown", "knitr","markdown","Hmisc"))
install.packages("rmarkdown", version = "2.11")
tinytex::install_tinytex()

install.packages(c( "car", "lme4", "lmtest", "ppcor"))
install.packages(c("sjPlot","sjmisc", "glmmTMB"))

install.packages(c("coda","mvtnorm","devtools","loo","dagitty","shape"))
devtools::install_github("rmcelreath/rethinking")

install.packages(c("CCA"))

install.packages(c("DescTools"))
