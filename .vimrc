set backspace=2
:syntax on
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'bazelbuild/vim-bazel'
Plugin 'wincent/terminus'

"Plugin 'davidhalter/jedi-vim'
call vundle#end()            " required
filetype plugin indent on    " required

call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  "autocmd FileType html,css,json AutoFormatBuffer js-beautify
  "autocmd FileType python AutoFormatBuffer yapf
augroup END

" 4 spaces is the default indentation performed by yapf (see above).
autocmd FileType python setlocal shiftwidth=4 tabstop=4


" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let g:ycm_global_ycm_extra_conf = "/home/vasiliy/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0


:set expandtab
:set tabstop=2
:set shiftwidth=2
:set hlsearch
set colorcolumn=80
colorscheme default
:hi ColorColumn ctermbg=darkgrey guibg=darkgrey
set tags=./tags,tags;$HOME

" Show whitespaces and other random hidden characters. 
set listchars=tab:>-,trail:·
set list

" This prevents you from scrolling into infinity past the file's end.
let g:TerminusMouse=0
