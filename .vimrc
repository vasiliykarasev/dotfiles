set backspace=2
:syntax on
set nocompatible              " be iMproved, required
filetype off                  " required
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set colorcolumn=80
hi ColorColumn ctermbg=darkgrey guibg=darkgrey
:set expandtab
:set hlsearch
set colorcolumn=80
colorscheme default
set tags=./tags,tags;$HOME




" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'bazelbuild/vim-bazel'
Plugin 'flazz/vim-colorschemes'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'
Plugin 'google/vim-maktaba'
Plugin 'junegunn/fzf.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'wincent/terminus'
"Plugin 'davidhalter/jedi-vim'
call vundle#end()            " required
filetype plugin indent on    " required

call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt google_java_executable="java -jar /path/to/google-java-format-VERSION-all-deps.jar"

" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_allow_changing_updatetime = 0
let g:ycm_show_diagnostics_ui = 0


" :Glaive codefmt clang_format_executable='clang-format-3.6'
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto AutoFormatBuffer clang-format
  "autocmd FileType html,css,json AutoFormatBuffer js-beautify
  "autocmd FileType python AutoFormatBuffer yapf
augroup END

" 4 spaces is the default indentation performed by yapf (see above).
autocmd FileType python setlocal shiftwidth=4 tabstop=4

" Help bazel figure out bazel syntax.
autocmd BufNewFile,BufRead *.BUILD set syntax=bzl
autocmd BufNewFile,BufRead WORKSPACE set syntax=bzl

let g:ycm_global_ycm_extra_conf = "/home/vasiliy/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0

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

" %% points to the current file's directory.
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" Inverse of "go-to-file" (consider as "back-from-file")
nmap bf <C-o>

