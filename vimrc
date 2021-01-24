" 忽略每一次开启文件后的询问
let g:ycm_confirm_extra_conf = 0


" 设置.cpp文件的起始头
autocmd BufNewFile *.cpp,*.[ch] exec ":call SetTitle()"
func SetTitle()
    call setline(1,"/************************************************************************")
    call append(line("."), "    > File Name: ".expand("%"))
    call append(line(".")+1, "    > Author: Lao Zhenyu")
    call append(line(".")+2, "    > Mail: LaoZhenyu_961112@163.com ")
    call append(line(".")+3, "    > Created Time: ".strftime("%c"))
    call append(line(".")+4, "************************************************************************/")
    call append(line(".")+5, "")
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾（这个功能实际没有被实现，即下面的语句无效，暂不知道原因）
    autocmd BufNewFile * normal G
endfunc

"C,C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -std=c++11 -o %<"
        exec "!time ./%<"
    endif
endfunc

"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
exec "w"
exec "!g++ % -g -o %<"
exec "!gdb ./%<"
endfunc
"
set tags=/home/lsh/files/tags

let Tlist_Auto_Open = 1
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
""""""""""""""""""""""""










" VIM 插件要求
set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" VIM 基础配置
syntax on                        "语法高亮
set number                       "设置行号
set relativenumber               "设置相对行号
set cursorline                   "设置下划线
set wrap                         "设置一行达到一定字符后换行
set showcmd                      "右下角显示普通模式下的按键信息
set wildmenu                     "补全窗口
set hlsearch                     "高亮搜索 " 搜索是 / 按键
set incsearch                    "边搜索边高亮
set ignorecase                   "搜索时忽略大小写
set smartcase                    "搜索时智能大小写,小写会匹配大写,大写不会匹配小写
set mouse=a                      "使用鼠标
set encoding=utf-8               "设置编码
set laststatus=2                 "两行状态行+一行命令行
set cindent                      "设置c语言自动对齐
set guifont=Menlo:h16:cANSI      "设置字体
" 下一行let有时候可以解决主题配色不对的问题
let &t_ut=''       
set expandtab                    "可以将tab转换为空格
set tabstop=4                    "读取文件时\t(tab) 解析成多少个空格
set shiftwidth=4                 "tab宽度
set softtabstop=4                "在删除tab的时候,每多少个空格会被理解为一个tab
set nolist                       "不显示非可见字符
set backspace=indent,eol,start   "使得back键在normal和insert模式下能从开头回到结尾
set foldmethod=indent            "收缩代码块
set foldlevel=99
set scrolloff=5                  "永远显示光标上下保留五行
set clipboard=unnamedplus        "vim剪贴板和系统剪贴板共享
" 以下三行会使得你的vim在normal模式和insert模式显示不一样的光标(不一定可用)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
set laststatus=2
set autochdir                    "使得vim执行在当前路径下
" 下一行 au 使得关闭vim下一次打开时光标停留在退出行上
au BufReadPost * if line ("'\"") > 1 && line ("'\"") <= line ("$") | exe "normal! g'\"" | endif


" 一些基础操作
" | mode   | key             | function                             |
" |--------+-----------------+--------------------------------------|
" | normal | d i "           | 在双引号内删除内容                   |
" | normal | y i ]           | 在中括号内复制内容                   |
" | normal | f v             | 查找下一个 v 字符                    |
" | normal | d f c           | 删除直到下一个 c 字符                |
" | normal | I               | 行首插入                             |
" | normal | A               | 行尾插入                             |
" | normal | / map           | 搜索 map 单词 - = 跳转               |
" | normal | <LEADER><ENTER> | 隐藏高亮,此时<leader>是空格          |
" | -      | shift v         | 选中行                               |
" | -      | ctrl v          | 选中块                               |
" | -      | ctrl i          | 下一个光标位置                       |
" | -      | ctrl o          | 上一个光标位置                       |
" | visual | :normal cmd     | 对选中区域执行normal下指令           |
" | normal | :w !sudo tee %  | 强制写入到当前位置(即使需要管理权限) |
" | normal | :%TOhtml        | 生成html文件                         |


" 插件操作
" | mode   | key           | function                                         |
" |--------+---------------+--------------------------------------------------|
" | -      | F2            | 函数列表                                         |
" | -      | F3            | 文件树                                           |
" | -      | F4            | 历史树                                           |
" |--------+---------------+--------------------------------------------------|
" | -      | F5            |                                                  |
" | -      | F6            |                                                  |
" | -      | F7            |                                                  |
" |--------+---------------+--------------------------------------------------|
" | -      | F8            | md                                               |
" | -      | F9            | md                                               |
" |--------+---------------+--------------------------------------------------|
" | normal | <ENTER>       | 快速选中最近包裹文字块                           |
" | visual | S (",',[,(,{) | 快速为内容增加括号或者引号                       |
" | normal | cs ' "        | 将单引号包裹替换为双引号,支持其他符号            |
" | normal | ctrl N        | 选中同名单词,多次ctrl N 多次选中后可以创建多光标 |
" | normal | <LEADER> l    | 背景虚化模式
 
" 按键映射
let mapleader=" "

map <LEADER><LEADER> <Esc>/Volumes<CR>:nohlsearch<CR>c4l
map s <nop>
map S :w<CR>
map Q :q<CR>
"map R :source ~/.vim/vimrc<CR>
"noremap <up> 5k
"noremap <down> 5j
noremap = nzz
noremap - Nzz
noremap <LEADER><CR> :nohlsearch<CR>

" 分屏
map si :set splitright<CR>:vsplit<CR>
map sn :set nosplitright<CR>:vsplit<CR>
map su :set nosplitbelow<CR>:split<CR> 
map se :set splitbelow<CR>:split<CR>
map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K


" 切屏 LEADER 是 空格键
map <LEADER><right> <C-w>l
map <LEADER><up> <C-w>k
map <LEADER><left> <C-w>h
map <LEADER><down> <C-w>j

" 方向键作为修改分屏的大小,但是不习惯,先不使用
"map <right> :vertical resize+5<CR>
"map <left> :vertical resize-5<CR>
"map <up> :res +5<CR>
"map <down> :res -5<CR>

" 标签页 
" tu 新增标签页
" t- 左移
" t= 右移
map tu :tabe<CR>
map t- :-tabnext<CR>
map t= :+tabnext<CR>

" 安装插件 by vim-plug
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'                                  "底部信息栏插件
Plug 'connorholyday/vim-snazzy'                                 "vim 主题
Plug 'tomasr/molokai'                                           "vim 主题
Plug 'morhetz/gruvbox'                                          "vim 主题
Plug 'altercation/solarized'                                    "vim 主题
Plug 'preservim/nerdtree'                                       "显示文件树
Plug 'Xuyuanp/nerdtree-git-plugin'                              "为文件树增加git的一些提示图标
Plug 'dense-analysis/ale'                                       "异步错误提醒
Plug 'preservim/tagbar'                                         "显示函数列表
Plug 'mbbill/undotree'                                          "显示历史修改(类似git,可以回滚)
Plug 'iamcco/markdown-preview.vim'                              "markdown文件实时预览
Plug 'ycm-core/YouCompleteMe'                                   "自动补全
Plug 'dhruvasagar/vim-table-mode'                               "自动对齐表格格式 | name | sex | age | 如此
Plug 'nathanaelkane/vim-indent-guides'                          "行首tab颜色区分,针对python这样需要多个tab的语言
"Plug 'neoclide/coc.nvim', {'branch': 'release'}                "一个国人写的补全框架(框架下还可以继续安装插件)
Plug 'junegunn/vim-peekaboo'                                    "可视化多号剪贴板
Plug 'gcmt/wildfire.vim'                                        "快速选中括号或者引号内容      <ENTER>
Plug 'tpope/vim-surround'                                       "快速为内容增加括号或者引号    选中后 S (",',(,[,{)   
Plug 'mg979/vim-visual-multi'                                   "多光标编辑
Plug 'Shougo/echodoc.vim'                                       "输入函数的参数列表显示
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }  "模糊匹配搜索本地文件
Plug 'junegunn/limelight.vim'                                   "非选中块背景虚化
Plug 'jiangmiao/auto-pairs'                                     "括号匹配
"Plug 'neoclide/coc.nvim', {'branch': 'release'}                 "COC框A架
Plug 'SirVer/ultisnips'                                         "snippets引擎
Plug 'honza/vim-snippets'                                       "snippets
call plug#end()


" plug: vim-airline 配置
" url : https://github.com/vim-airline/vim-airline
" 暂时不配置

" plug: vim-snazzy 主题配置
colorscheme snazzy
let g:lightline={'colorscheme':'snazzy'}
let g:SnazzyTransparent = 1


" plug: nerdtree 文件树配置
nmap <F3> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '-'
let g:NERDTreeDirArrowCollapsible = '|'

" plug: nerdtree-git 文件树git图标配置
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }



" plug: tagbar 函数列表配置
nmap <F2> :TagbarToggle<CR>

" plug: undotree 历史树
nnoremap <F4> :UndotreeToggle<CR>

" plug: markdown md文件实时预览
" :MarkdownPreview 预览
" :MarkdownPreviewStop 停止预览
" for normal mode
nmap <silent> <F8> <Plug>MarkdownPreview
" for insert mode
imap <silent> <F8> <Plug>MarkdownPreview
" for normal mode
nmap <silent> <F9> <Plug>StopMarkdownPreview
" for insert mode
imap <silent> <F9> <Plug>StopMarkdownPreview


" plug: You Compelete Me
nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap g/ :YcmCompleter GetDoc<CR>
nnoremap gt :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_use_clangd=0
let g:ycm_python_interpreter_path="/bin/python3"
let g:ycm_python_binary_path="/bin/python3"
let g:ycm_collect_identifiers_from_tags_files = 1           " 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 注释与字符串中的内容也用于补全
let g:ycm_seed_identifiers_with_syntax = 1                  " 语法关键字补全
let g:ycm_complete_in_comments = 1                          " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                           " 在字符串输入中也能补全

" plug: ale 语法纠正
let b:ale_linters = ['pylint']
let b:ale_fixers = ['autopep8','yapf']
" let g:ale_linters_explicit = 1
" let g:ale_completion_delay = 500
" let g:ale_echo_delay = 20
" let g:ale_lint_delay = 500
" let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_lint_on_text_changed = 'normal'
" let g:ale_lint_on_insert_leave = 1
" let g:airline#extensions#ale#enabled = 1
" 
" let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
" let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
" let g:ale_c_cppcheck_options = ''
" let g:ale_cpp_cppcheck_options = ''


" plug: vim-table-mode 表格模式
" | name | age |
" |------+-----|
" | oxy  |  15 |
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'


" plug: vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2


" plug: echodoc 输入函数的参数列表显示
set noshowmode
let g:echodoc_enable_at_startup = 1

" plug: LeaderF 模糊文件搜索


" limelight 背景虚化配置
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Default: 0.5
let g:limelight_default_coefficient = 0.7
" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1
" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
nmap <Leader>l :Limelight!! 0.5<CR> 

" plug: snippets
let g:UltiSnipsExpandTrigger = "<tab>" 
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/plugged/vim-snippets/UltiSnips']
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
