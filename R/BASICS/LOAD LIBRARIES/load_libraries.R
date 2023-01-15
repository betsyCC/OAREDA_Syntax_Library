# Load R libraries

# This script loads R packages using pacman, an R package management tool. 
# https://github.com/trinker/pacman 



# Check if "pacman" is installed before loading
if (!require("pacman")) install.packages("pacman")

library(pacman)


# set cran repo in case installations are required

pacman:::p_set_cranrepo(default_repo = "https://cran.rstudio.com")

# p_load(): install.packages() + library(). 
# It will first check if all the packages are installed and if not, it will install and then load 

p_load(DBI, odbc, svDialogs,
       tidyverse, magrittr, janitor, forcats,
       data.table, vroom, readxl, writexl, 
       lubridate, fasttime, 
       knitr, bookdown, revealjs, 
       kableExtra, gt, gtsummary, scales,
       ggforce, ggdist, ggbeeswarm, gghalves, ggrepel, ggsci, ggthemes, ggtext, cowplot, plotly, ragg, Rcpp,
       unikn, extrafont, DiagrammeR,
       usethis, gitcreds,
       fs, 
       install = TRUE)

# provide package URL if you want to download a specific version
# packageurl <- "https://cran.r-project.org/src/contrib/Archive/odbc/odbc_1.2.3.tar.gz"
# install.packages(packageurl, repos=NULL, type="source")
# use p_install_gh("username/repo") to install from Github


# Other useful functions:

# p_loaded(): list loaded packages
# p_unload(): detach package

# p_lib(): list packages in user library
# save out a list of packages to easily update packages when R is updated to a new version:

full_library<-p_library()

saveRDS(full_library, "R:\\REPS Team\\Hayden Ju\\full_library.RDS")