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

" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'  
" Shut up about extra-conf options.
let g:ycm_extra_conf_globlist = ['~/*']

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
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/fzf.vim'
Plugin 'wincent/terminus'
Plugin 'vim-airline/vim-airline'
Plugin 'leafgarland/typescript-vim'
Plugin 'bazelbuild/vim-bazel'

call vundle#end() " required
call glaive#Install()

let g:cpp_experimental_simple_template_highlight = 0
let g:cpp_experimental_template_highlight = 0

Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

filetype plugin indent on    " required

" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_allow_changing_updatetime = 0
let g:ycm_show_diagnostics_ui = 0
" To ignore plugin indent changes, instead use:
"
"
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

:Glaive codefmt clang_format_executable='clang-format-3.6'
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp AutoFormatBuffer clang-format
  " autocmd FileType proto AutoFormatBuffer clang-format
  " autocmd FileType python AutoFormatBuffer yapf " this is way way too slow.
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

:set hlsearch

" Show whitespaces and other random hidden characters. 
set listchars=tab:>-,trail:·
set list

" This prevents you from scrolling into infinity past the file's end.
let g:TerminusMouse=0

function StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

command! StripTrailingWhitespace call StripTrailingWhitespace()

" Run buildifier on the current file.
function Buildifier()
  %!buildifier
endfunction
command! Buildifier call Buildifier()

let g:typescript_indent_disable = 1

" Hacks taken from https://github.com/bazelbuild/vim-bazel/issues/4
function! BazelGetCurrentBufTarget()
  " Doing a bazel query is sadly very slow. It would be better just to parse
  " the filename, get basename and remove the extension. 
  " This should work in many cases.
  let bazel_file_label=system("bazel query " . bufname("%") . " --color no --curses no --noshow_progress | tr -d '[:space:]'")
  let bazel_file_package=split(bazel_file_label, ":")[0]
  let g:current_bazel_target=system("bazel query \"attr('srcs', " . bazel_file_label . ", " . bazel_file_package . ":*)\" --color no --curses no --noshow_progress | tr -d '[:space:]'")
endfunction

function! BazelBuildThis()
  :call  BazelGetCurrentBufTarget()
  :execute '!bazel build ' . g:current_bazel_target
endfunction

function! BazelRunThis()
  :call BazelGetCurrentBufTarget()
  :execute '!brun ' . g:current_bazel_target
endfunction

command! BazelBuildThis call BazelBuildThis()
command! BazelRunThis call BazelRunThis()

