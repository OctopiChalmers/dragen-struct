(TeX-add-style-hook
 "main.lhs"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("IEEEtran" "conference")))
   (TeX-run-style-hooks
    "latex2e"
    "IEEEtran"
    "IEEEtran10"
    "todonotes"
    "cite"
    "amsmath"
    "amssymb"
    "amsfonts"
    "algorithmic"
    "graphicx"
    "textcomp"
    "xcolor"
    "tikz"
    "mathdots"
    "yhmath"
    "cancel"
    "color"
    "siunitx"
    "array"
    "multirow"
    "gensymb"
    "tabularx"
    "booktabs"
    "caption"
    "xspace")
   (TeX-add-symbols
    "tocite"
    "quickcheck"
    "megadeth"
    "dragen")
   (LaTeX-add-bibliographies
    "references.bib"))
 :latex)

