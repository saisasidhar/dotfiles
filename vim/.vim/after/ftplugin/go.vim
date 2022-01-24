setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

let g:go_list_type = "quickfix"
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1

hi def link goFunctionCall Function
hi def link goConditional Keyword
hi def link goRepeat Keyword
hi def link goLabel Keyword
hi goBuiltins guifg=#B3ADF3 gui=NONE ctermfg=117 cterm=NONE
