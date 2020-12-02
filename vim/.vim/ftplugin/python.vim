set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
set number
setlocal colorcolumn=80

setlocal path=.,**
setlocal wildignore=*.pyc

setlocal include=^\\s*import
setlocal define=^\\s*\\<\\(def\\\|class\\)\\>
