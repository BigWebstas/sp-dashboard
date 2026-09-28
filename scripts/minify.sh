#!/bin/bash

PROJECT="$1"
# mangle.toplevel is safe here specifically because every top-level function an
# inline onclick/onchange attribute calls by name (switchTab, setDrillDimension,
# setDrillEntity) is also explicitly assigned as window.<name> = <name> at the
# bottom of the script (originally for test exposure — see CLAUDE.md). A bare
# identifier reference from an inline HTML attribute resolves through the global
# object once mangling removes the matching lexical binding, so renaming the
# declaration does not break the attribute's call. If a future onclick/onchange
# handler calls a function that is NOT in that window.* exposure list, mangling
# will silently break it — keep the two in sync.
html-minifier-terser \
    --collapse-whitespace \
    --remove-comments \
    --remove-optional-tags \
    --minify-css true \
    --minify-js '{"mangle":{"toplevel":true}}' \
    -o build/$PROJECT/index.html $PROJECT/index.html