" use vim defaults
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

" disable vim-polyglot automatic settings
let g:polyglot_disabled = ['autoindent', 'sensible']

" already done by vim-polyglot
" syntax on
" filetype plugin indent on
" runtime macros/matchit.vim

"""" pre-colorscheme terminal config

" see :h xterm-true-color
" let &t_8f="[38;2;%lu;%lu;%lum"
" let &t_8b="[48;2;%lu;%lu;%lum"

" disable page flip on suspend/exit
" set t_ti=
" set t_te=

" disable bold
" set t_md=

" define italics mode/end sequences if $TERM supports them
" if &term=~'xterm-256color'
" 	set t_ZH=[3m
" 	set t_ZR=[23m

	" define italics for colorschemes without them
	" augroup Italics
	" 	au!
	" 	autocmd ColorScheme * highlight Comment cterm = italic gui = italic
	" 	autocmd ColorScheme * highlight SpecialComment cterm = italic gui = italic
	" augroup END
" endif

" change ColorColumn highlight
" replace CursorColumn with syntax to link to, or define something else
augroup ColorColumnHl
	au!
	autocmd ColorScheme * highlight clear ColorColumn
	autocmd ColorScheme * highlight link  ColorColumn CursorColumn
augroup END

"""" colorscheme

" jellybeans
" set background=dark
" let g:lightline={'colorscheme': 'jellybeans'}
" let g:jellybeans_overrides={'background': {'256ctermbg': 'none'}}
" let g:jellybeans_use_term_italics=1
" colorscheme jellybeans

" selenized
set background=dark
let g:lightline = {'colorscheme': 'selenized_dark'}
" for non-truecolor terminals (Terminal.app), where
" ANSI colors define the colorscheme.
if !has('nvim')
	set t_Co=16
endif
colorscheme selenized

"""" settings

" no powerline separators in tmuxline
" let g:tmuxline_powerline_separators = 0

set formatoptions+=j
set ignorecase
set laststatus=2
set lazyredraw
set listchars=eol:$,tab:>_,trail:.,extends:>,precedes:<,nbsp:%
" reset modelines; default is 5, but vim starts with 0 (?)
" set modelines&
set noshowmode
set smartcase
set spelllang=en_us
set ttyfast

"""" augroups

" use xxd to hexedit binary files, disk images (:help hex-editing)
" augroup HexEdit
" 	au!
" 	au BufReadPre   *.{2mg,bin,dsk,po} let &bin = 1
" 	au BufReadPost  *.{2mg,bin,dsk,po} if &bin | %!xxd
" 	au BufReadPost  *.{2mg,bin,dsk,po} set ft=binary | endif
" 	au BufWritePre  *.{2mg,bin,dsk,po} if &bin | %!xxd -r
" 	au BufWritePre  *.{2mg,bin,dsk,po} endif
" 	au BufWritePost *.{2mg,bin,dsk,po} if &bin | %!xxd
" 	au BufWritePost *.{2mg,bin,dsk,po} set nomod | endif
" augroup END

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

" augroup BufferCommands
" 	au!
	" vim help mapping
	" https://stackoverflow.com/q/30820942
	" au FileType help call s:InHelp()
	" function! s:InHelp()
		" tab/shift-tab jumps to next/previous vim help tag
		" nnoremap <buffer> <Tab> /\|[^\|]*\|<CR>l
		" nnoremap <buffer> <S-Tab> h?\|[^\|]*\|<CR>l
		" q quits
		" nnoremap <buffer> q :q<CR>
	" endfunction
" augroup END

" make programs
augroup MakeProgs
	au!
	au Filetype lilypond setlocal makeprg=lilypond\ %\ &&\ open\ %:r.pdf
augroup END

" screensaver
" NOTE: CursorHold gets called on window resize
" NOTE: updatetime is also the time until the swapfile is written
" set updatetime=300000
" augroup Screensaver
"	au!
"	au CursorHold * nested Nyancat
" augroup END

"""" commands

" :R [command ...] puts output of shell 'command' in a scratch buffer
" http://vim.wikia.com/wiki/Append_output_of_an_external_command
command! -nargs=* -complete=shellcmd R new | setlocal buftype=nofile bufhidden=hide noswapfile | r !<args>

" :S creates a new scratch buffer
command! S new | setlocal buftype=nofile bufhidden=hide noswapfile

" :Helptags generates tags/help for vim plugins inside ~/.vim
command! Helptags !find ~/.vim/ -type d -name doc -exec vim -c "helptags \{}" -c q \;

" find consecutive duplicate lines
command! -range=% Dupe <line1>,<line2>/^\(.*\)$\n\1$

" squeeze multiple blank lines
command! -range=% Squeeze <line1>,<line2>s/\n\{3,\}/\r\r/

" strip appended whitespace
command! -range=% Strip <line1>,<line2>s/\s\+$//g

"""" mapping

" shift-tab previous jump
nnoremap <S-Tab> <C-O>

" keep visual selection when shifting left/right (vim-galore)
xnoremap < <gv
xnoremap > >gv

" mute highlight search on redraw
" nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" previous/next buffer
nnoremap [b :bNext<CR>
nnoremap ]b :bnext<CR>

nnoremap <silent> <Leader><Tab> :set expandtab! <Bar> set expandtab?<CR>

" find appended white space
noremap <Leader><Space> /\s\+$<CR>

" find multiple blank lines
noremap <Leader><CR> /\n\{3,\}<CR>

" adjust tab widths
noremap <Leader>2 :set shiftwidth=2 <Bar> set tabstop=2<CR>
noremap <Leader>4 :set shiftwidth=4 <Bar> set tabstop=4<CR>
noremap <Leader>8 :set shiftwidth=8 <Bar> set tabstop=8<CR>

" align left/center/right
" noremap <Leader>< :left<CR>
" noremap <Leader>- :center<CR>
" noremap <Leader>> :right<CR>

" insert timestamp and start journal/log entry
nnoremap <silent> <Leader>@ :-1r!date '+\%A \%B \%d, \%Y \%I:\%M \%p'<CR>i# <Esc>$a:<Space>

" forward/backward to char under cursor across lines
" nnoremap <silent> <Leader>; yl/\V<C-R>=escape(@", getcmdtype().'\')<CR><CR>
" nnoremap <silent> <Leader>, yl?\V<C-R>=escape(@", getcmdtype().'\')<CR><CR>

" nnoremap <silent> <Leader>) :call MatchParenToggle()<CR>

" nnoremap <silent> <Leader>b :set linebreak! <Bar> set linebreak?<CR>
" nnoremap <silent> <Leader>B :call ShowBreakToggle()<CR>

" nnoremap <silent> <Leader>c :set ignorecase! <Bar> set ignorecase?<CR>

" noremap <Leader>e :Explore<CR>
" noremap <Leader>E :Rexplore<CR>

" nnoremap <silent> <Leader>h :set hlsearch! <Bar> set hlsearch?<CR>

nnoremap <silent> <Leader>i :set incsearch! <Bar> set incsearch?<CR>

" copy visual selection to system clipboard
" vnoremap <silent> <Leader>k :w !pbcopy<CR><CR>
" copy entire buffer to system clipboard
" nnoremap <silent> <Leader>K :%w !pbcopy<CR><CR>

nnoremap <silent> <Leader>l :set list! <Bar> set list?<CR>

" nnoremap <silent> <Leader>m :make<CR>

" edit macro register (from vim-galore)
" nnoremap <Leader>M :<C-U><C-R>='let @'. v:register .'='. string(getreg(v:register))<CR><C-F>03Wl

nnoremap <silent> <Leader>n :set number! <Bar> set number?<CR>
nnoremap <silent> <Leader>N :set relativenumber! <Bar> set relativenumber?<CR>

" EOL paste (append space then paste at EOL)
" nnoremap <silent> <Leader>p A <Esc>p

" paste from os clipboard
" nnoremap <silent> <Leader>P :r !pbpaste -Prefer txt<CR>

" format the current paragraph or selection
" vnoremap <Leader>q gq
" nnoremap <Leader>q gqap

noremap <Leader>r :retab<CR>
noremap <Leader>R :retab!<CR>

nnoremap <silent> <Leader>s :set scrollbind! <Bar> set scrollbind?<CR>
nnoremap <silent> <Leader>S :set spell! <Bar> set spell?<CR>

nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>T :tabclose<CR>
nnoremap <Leader>] :tabnext<CR>
nnoremap <Leader>[ :tabprevious<CR>
nnoremap <Leader>} :tabmove<CR>
nnoremap <Leader>{ :tabmove -1<CR>

" visual select last edited/pasted selection
" nnoremap <Leader>v `[v`]

nnoremap <Leader>V :source $MYVIMRC<CR>

nnoremap <silent> <Leader>w :set wrap! <Bar> set wrap?<CR>

" nnoremap <silent> <Leader>x :set cursorline! <Bar> set cursorline?<CR>
" nnoremap <silent> <Leader>y :set cursorcolumn! <Bar> set cursorcolumn?<CR>

" nnoremap <silent> <Leader>z :call ColorColumnToggle()<CR>
" find next line >= 80 characters
" nnoremap <silent> <Leader>Z /^.\{80,\}<CR>


"""" functions

" with multiple windows, Do/NoMatchParen moves cursor to first window (bug?)
" function! MatchParenToggle()
" 	if exists("g:loaded_matchparen")
" 		NoMatchParen
" 		echo "matchparen off"
" 	else
" 		DoMatchParen
" 		echo "matchparen on"
" 	endif
" endfunction

" function! ShowBreakToggle()
" 	if &showbreak =~ '> '
" 		let &showbreak = ''
" 		echo "showbreak off"
" 	else
" 		let &showbreak = '> '
" 		echo "showbreak on"
" 	endif
" endfunction

" function! ColorColumnToggle()
" 	if &colorcolumn == 0
" 		set colorcolumn=80
" 	else
" 		set colorcolumn&
" 	endif
" endfunction
