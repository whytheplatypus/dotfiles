inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
let g:completor_gocode_binary = '/home/whytheplatypus/.golang/bin/gocode'

let g:completor_racer_binary = '/home/whytheplatypus/.cargo/bin/racer'
