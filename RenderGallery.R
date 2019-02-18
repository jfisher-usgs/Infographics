#!/usr/bin/env Rscript

RenderGallery <- function(path=".") {
  file.names <- list.files("./img", "*.png$")
  if (length(file.names) == 0) stop("no PNG images found")
  x <- tools::file_path_sans_ext(file.names)
  x <- gsub("_", " ", x)
  x <- gsub("\\b([[:lower:]])([[:lower:]]+)", "\\U\\1\\L\\2", x, perl=TRUE)
  base.names <- x

  con <- file(file.path(path, "index.Rmd"))
  on.exit(close(con))

  fmt <- "### %s\n\n![](./img/%s)\n\n---\n"
  s <- vapply(seq_along(file.names), function(i) {
    sprintf(fmt, base.names[i], file.names[i])
  }, "")
  cat("---\nlayout: page\ntitle: Infographics\n---\n", s,
      file=con, sep="\n")

  rmarkdown::render("index.Rmd", "html_document")

  invisible(NULL)
}

RenderGallery(".")
