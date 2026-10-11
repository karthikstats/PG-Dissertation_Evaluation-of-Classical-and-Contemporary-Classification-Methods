#######Solution for CRAN Problem Package######

options(repos = c(CRAN = "https://cloud.r-project.org"))

getOption("repos")

cat(
  'options(repos = c(CRAN = "https://cloud.r-project.org"))\n',
  file = file.path(Sys.getenv("HOME"), ".Rprofile"),
  append = TRUE
)

#Now close and Open again and chk

getOption("repos")

# it shows CRAN 
# "https://cloud.r-project.org"

