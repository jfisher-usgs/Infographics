#!/usr/bin/env Rscript

RenderGallery <- function(path=".") {
  file.names <- list.files("./img", "*.png$")
  if (length(file.names) == 0) stop("no PNG images found")
  x <- tools::file_path_sans_ext(file.names)
  x <- gsub("_", " ", x)
  x <- gsub("\\b([[:lower:]])([[:lower:]]+)", "\\U\\1\\L\\2", x, perl=TRUE)
  base.names <- x
  meta <- c("---",
            "title: Infographics",
            "author: Jason C. Fisher",
            "output:",
            "  html_document:",
            "    toc: true",
            "    toc_float: true",
            "    mathjax: null",
            "---\n")
  s <- vapply(seq_along(file.names), function(i) {
    sprintf("### %s\n\n![](./img/%s)\n\n---\n", base.names[i], file.names[i])
  }, "")
  con <- file(file.path(path, "index.Rmd")); on.exit(close(con))
  cat(meta, s, file=con, sep="\n")
  rmarkdown::render("index.Rmd")
  invisible(NULL)
}

RenderGallery(".")
