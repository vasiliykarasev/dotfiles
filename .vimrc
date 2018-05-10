syntax on
set backspace=indent,eol,start
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set colorcolumn=80
hi ColorColumn ctermbg=darkgrey guibg=lightgrey
set number

filetype indent on
filetype plugin on

set tags=./tags,tags;$HOME

set nocompatible              " be iMproved, required
filetype off                  " required

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'valloric/YouCompleteMe'

" Add maktaba and codefmt to the runtimepath.
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

call vundle#end() " required
call glaive#Install()

Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

:Glaive codefmt clang_format_executable='clang-format-3.6'
augroup autoformat_settings
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  " autocmd FileType python AutoFormatBuffer yapf " this is way way too slow.
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

