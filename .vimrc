set nocompatible

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"set encoding=utf-8

if(has("win32") || has("win95") || has("win64") || has("win16")) "判定当前操作系统类型
    let g:iswindows=1
else
    let g:iswindows=0
endif

let HOME=expand('$HOME')
let __DIR__=HOME."/Vim-Configuration/"
let $AddonDir=__DIR__."vim-addons/"
let $AddonUtilDir=$AddonDir.'binary-utils/dist/win'
let $TMP=__DIR__."tmp"

cd %:p:h

set number
set numberwidth=2
set wrap

set guifont=Consolas:h10:cANSI
"set columns=100
"set lines=30
set guifontwide=Simsun-ExtB:h12

set tabstop=4 expandtab"让一个tab等于4个空格
set shiftwidth=4
set softtabstop=4

set statusline=%F%m%r%h%w\ [%{&ff}][%Y]\ [%p%%][%L][%l,%v]\ [ASCII=\%b]

set go=m
syntax on "打开高亮
filetype plugin indent on "根据文件进行缩进

set incsearch "在输入要搜索的文字时，vim会实时匹配

function SetupVAM()
    exec 'set runtimepath+='.$AddonDir.'/vim-addon-manager'

    call vam#ActivateAddons(['minibufexpl','winmanager','The_NERD_tree','phpcs','pythoncomplete','JavaScript_Indent','JavaScript_syntax'], {'auto_install' : 0})

endfunction

call SetupVAM()
" experimental: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
function LoadPlugin()
    "NERDTree
    "call vam#ActivateAddons(['snipmate'],{'auto_install':0})
endfunction

function LoadProgramPlugin()
    call LoadPlugin()
    "TlistOpen
endfunction

function LoadCPlugin()
    call LoadProgramPlugin()
    set tags+=$AddonDir/tags/libc.tags
endfunction

function LoadCppPlugin()
    call LoadCPlugin()
    set tags+=$AddonDir/tags/cppstl.tags
endfunction

function LoadPyPlugin()
    call LoadProgramPlugin()
    filetype plugin on
    set ofu=syntaxcomplete
endfunction

function LoadPhpPlugin()
    call LoadProgramPlugin()
    set expandtab
    set shiftwidth=4
    set tabstop=4
endfunction

function LoadDiaryPlugin()
    set columns=84
    set fo+=m
    set textwidth=80
endfunction

autocmd FileType c call LoadCPlugin()
autocmd FileType cpp call LoadCppPlugin()
autocmd FileType python call LoadPyPlugin()
autocmd BufRead,BufNewFile php call LoadPhpPlugin()
autocmd BufRead,BufNewFile *.diary call LoadDiaryPlugin()
source $AddonDir/keymap.vim
"call LoadPlugin()
"""""Surround""""
call vam#ActivateAddons(['Color_Sampler_Pack','surround','Highlight_UnMatched_Brackets'],{'auto_install':0})
"""""""""""""""""
""""AutoComplPop & snipMate""""
let g:acp_behaviorSnipmateLength=2
let g:acp_behaviorKeywordIgnores=['get', 'set']
let g:acp_behaviorFileLength=3
call vam#ActivateAddons(['snipMate', 'AutoComplPop'],{'auto_install':0})
"""""""""""""""""""""""""""""""
""""vimwiki""""
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path': __DIR__.'wiki/',
            \ 'path_html': __DIR__.'wiki/html/',
            \ 'html_header': __DIR__.'wiki/template/header.tpl',
            \ 'auto_export':1,
            \ 'template_path': __DIR__.'wiki/html/templates/',
            \ 'template_default': "base",
            \ 'template_ext': '.html',
            \ 'css_name': 'style.css',
            \ 'nested_syntaxes': {'python': 'python', 'c++': 'cpp'}}]
call vam#ActivateAddons(['vimwiki'],{'auto_install':0})
"""""""""""""""

let g:winManagerWindowLayout = "BufExplorer,FileExplorer|TagList"
let g:winManagerWidth = 30
let g:defaultExplorer = 1

""""calendar""""
let g:calendar_diary=__DIR__."diary"
let g:calendar_mark='right'
let g:calendar_navi_label='上页,今天,下页'
let g:calendar_wruler='日 一 二 三 四 五 六'
"let g:calendar_weeknm=1
let g:calendar_datetime='statusline'
let g:calendar_focus_today = 1
call vam#ActivateAddons(['calendar52'],{'auto_install':0})
"""""""""""""""""
call vam#ActivateAddons(['taglist'],{'auto_install':0})
colorscheme molokai
