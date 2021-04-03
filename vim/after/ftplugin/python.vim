setlocal tabstop=4 softtabstop=4 shiftwidth=4
setlocal colorcolumn=80

setlocal path=.,**
setlocal wildignore=*.pyc,*/__pycache__/*,*/venv/*

hi def link pythonInclude Keyword
hi def link pythonConditional Keyword
hi def link pythonException Keyword
hi def link pythonRepeat Keyword
hi def link pythonOperator Keyword
hi pythonBuiltin guifg=#B2ADF3 gui=NONE ctermfg=117 cterm=NONE

" TODO ctags gen
