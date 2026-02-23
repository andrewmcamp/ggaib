.onLoad <- function(libname, pkgname) {
  register_aib_fonts()
}

.onAttach <- function(libname, pkgname) {
  fonts <- .aib_env$fonts
  if (is.null(fonts)) return(invisible())

  tier <- vapply(names(.font_config), function(role) {
    if (fonts[[role]] == .font_config[[role]]$preferred) {
      "brand"
    } else if (fonts[[role]] == .font_config[[role]]$fallback) {
      "bundled"
    } else {
      "default"
    }
  }, character(1))

  if (all(tier == "brand")) {
    packageStartupMessage(
      "Using AIB brand fonts (Area Normal, Source Sans Pro, Minion Pro)."
    )
  } else if (all(tier == "bundled")) {
    packageStartupMessage(
      "Brand fonts not found. Using bundled alternatives ",
      "(Albert Sans, Source Sans 3, Crimson Text)."
    )
  } else if (all(tier == "default")) {
    packageStartupMessage(
      "Font registration failed. Using system defaults (sans/serif)."
    )
  } else {
    labels <- vapply(names(.font_config), function(role) {
      tag <- switch(tier[role],
        brand   = "brand",
        bundled = "bundled",
        "default"
      )
      paste0(fonts[[role]], " (", tag, ")")
    }, character(1))
    packageStartupMessage("Fonts: ", paste(labels, collapse = ", "), ".")
  }
}
