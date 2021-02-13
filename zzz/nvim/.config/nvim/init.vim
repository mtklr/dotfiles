" ~/.config/nvim/init.vim

set termguicolors

" colors/terminfo bce bug workaround (see kitty FAQ)
" let &t_ut=''

" disable cursor styling
" set guicursor=

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc
