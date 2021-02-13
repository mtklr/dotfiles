" ~/.vim/ftplugin/help.vim
" easier navigation for help buffer

" return/backspace jump forward/back
nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-T>
" o/O next/previous option
nnoremap <buffer> o /'\l\{2,\}'<CR>
nnoremap <buffer> O ?'\l\{2,\}'<CR>
" Tab/S-Tab next/previous subject
nnoremap <buffer> <Tab> /\|\zs\S\+\ze\|<CR>
nnoremap <buffer> <S-Tab> ?\|\zs\S\+\ze\|<CR>
" q quits
nnoremap <buffer> q :q<CR>
