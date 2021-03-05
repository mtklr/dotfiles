" colorscheme:
" ~/.vim/pack/colors/opt/selenized/colors/
"	selenized/ # https://github.com/jan-warchol/selenized
"		selenized.vim
"		selenized_bw.vim
" plugins:
" ~/.vim/pack/plugins/start/
"	lightline.vim
"	vim-commentary
"	vim-gitgutter
"	vim-polyglot
"	vim-surround

"	use vim defaults
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" don't remember last cursor position
augroup vimStartup | au! | augroup END

" disable vim-polyglot automatic settings
let g:polyglot_disabled = ['autoindent', 'sensible']

" already handled by vim-polyglot
" syntax on
" filetype plugin indent on
" runtime macros/matchit.vim

" color
" for terminals where custom ANSI colors are used for the colorscheme
" instead of 256color approximations, which look bad.
" ignore for nvim in a truecolor terminal.
if !has('nvim')
	set t_Co=16
endif

let g:lightline = {'colorscheme': 'selenized_dark'}
colorscheme selenized

" make
augroup MakeProgs
	au!
	au Filetype lilypond setlocal makeprg=lilypond\ %\ &&\ open\ %:r.pdf
augroup END

" more types for vim-commentary
augroup CommentaryTypes
	au!
	" expect
	au BufEnter * if &ft == 'expect' | setlocal commentstring=#%s | endif

	" gitconfig
	au BufRead,BufNewFile gitconfig setfiletype gitconfig
	au BufEnter * if &ft == 'gitconfig' | setlocal commentstring=;%s | endif

	" lilypond
	au BufEnter * if &ft == 'lilypond' | setlocal commentstring=\%%s | endif

	" manpage
	au BufEnter * if &ft == 'nroff' | setlocal commentstring=\.\\\"%s | endif
augroup END

" options
set hidden
set ignorecase
set laststatus=2
set listchars+=tab:>_
set mouse&
set noshowmode
set smartcase
set shiftwidth=0	" follow tabstop
set softtabstop=-1	" use shiftwidth value
set noswapfile

" map
" help buffer mapping: ~/.vim/ftplugin/help.vim
nnoremap <Leader><Tab> :set expandtab! <Bar> set expandtab?<CR>
nnoremap <Leader>2 :set ts=2 <Bar> set ts?<CR>
nnoremap <Leader>4 :set ts=4 <Bar> set ts?<CR>
nnoremap <Leader>8 :set ts=8 <Bar> set ts?<CR>
nnoremap <Leader>i :set incsearch! <Bar> set incsearch?<CR>
nnoremap <Leader>l :set list! <Bar> set list?<CR>
nnoremap <Leader>n :set number! <Bar> set number?<CR>
nnoremap <Leader>N :set relativenumber! <Bar> set relativenumber?<CR>
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabclose<CR>
nnoremap <Leader>w :set wrap! <Bar> set wrap?<CR>
nnoremap <Leader>{ :tabmove -1<CR>
nnoremap <Leader>} :tabmove +1<CR>
nnoremap [<Space> O<Esc>
nnoremap ]<Space> o<Esc>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>
nnoremap [b :bNext<CR>
nnoremap ]b :bnext<CR>
nnoremap [T :tabfirst<CR>
nnoremap ]T :tablast<CR>
nnoremap [t :tabNext<CR>
nnoremap ]t :tabnext<CR>
