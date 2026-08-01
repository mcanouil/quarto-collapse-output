# The documentation website shares the renv environment declared at the
# repository root rather than carrying a lockfile of its own: the R the pages
# execute is the R the extension is developed against.
#
# RENV_PROJECT has to be set before the activate script runs. Without it renv
# takes the working directory for the project, looks for docs/renv/library, and
# finds nothing.
Sys.setenv(RENV_PROJECT = normalizePath("..", mustWork = TRUE))
source("../renv/activate.R")
