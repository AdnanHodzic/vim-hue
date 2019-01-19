colo hue						" set hue color scheme
set t_Co=256					" use 256 colors
set encoding=utf-8				" utf-8 character encoding
set tabstop=2					" tab 2 spaces
set softtabstop=2				" tab inserts a combination of spaces to simulate tab stops at this width.
set expandtab					" expand tabs into spaces
set shiftwidth=2				" when using the >> or << commands, shift lines by 4 space
set autoindent					" indent when moving to the next line while writing code
set fileformat=unix				" convert file to unix file convention
set textwidth=80				" text wrapping after 80 characters
set showmatch					" show matching bracets
set hlsearch					" highlight searches
let python_highlight_all = 1	"enable all Python syntax highlighting features
set nu							" show line numbers
set showmatch					" show the matching part of the pair for [] {} and ()
set list						" display whitespace
" all yanking goes to clipboard (install vim-gtk)
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
set paste						" Paste from a windows or from vim (shift + p preserve indent)
set ignorecase					" case insensitive search
set laststatus=2				" enable status bar
set cursorline					" show a visual line under the cursor's current line
"match ErrorMsg '\%>80v.\+'		" highlight in red anything > 80 chars
set lcs=tab:│┈,trail:·,extends:>,precedes:<,nbsp:&	" display tabs spaces
set statusline=\ %f%m%r%h%w\ %=%({%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y}%)\ %([%l,%v][%p%%]\ %)%#ErrorMsg#%{GitBranchInfoString()}	" extend status bar
let g:git_branch_status_head_current=1 " show branch info in case git repo
let g:git_branch_status_nogit="" " show nothing in case != git repo
set backspace=indent,eol,start " fix backspace doesn't work during insert (https://goo.gl/fizWK6)
" json auto format/indent/lint (experimental)
" autocmd FileType json autocmd BufWritePre <buffer> %!python -m json.tool
" enable Pathogen runtime
set nocp
call pathogen#infect()
syntax on						" enable syntax coloring/highlighting 
filetype indent plugin on		" automatic code indentation
