syntax on

filetype plugin indent on
filetype plugin on

set number
set mouse=a

execute "set directory=~/.vim/swap//"
execute "set backupdir=~/.vim/backup//"
execute "set undodir=~/.vim/undo//"
set laststatus=2
set undofile

:autocmd VimResized * wincmd =
