" 已经安装的插件
    " Bundle 'kien/ctrlp.vim'
    " Bundle 'scrooloose/nerdcommenter'
    " Bundle 'BufOnly.vim'
    " Bundle 'scrooloose/nerdtree'
    " Bundle 'airblade/vim-gitgutter'
      "   airblade/vim-gitgutter 貌似和scrooloose/syntastic在行号栏中显示有冲突???
      "   https://github.com/airblade/vim-gitgutter中有说明，vim-gitgutter如果和其他插件有冲突，那么在有冲突的行上面显示其他插件的内容
    " Bundle 'scrooloose/syntastic'  "语法检测
    " Bundle 'Lokaltog/vim-powerline'  " -- 标尺插件
    " Bundle 'jlanzarotta/bufexplorer'
    " Bundle 'tpope/vim-endwise'
    " Bundle 'Xuyuanp/nerdtree-git-plugin'
    " Bundle 'vim-scripts/Mark--Karkat'
    " Bundle 'mbbill/undotree'
    " Bundle 'SirVer/ultisnips'
    " Bundle 'honza/vim-snippets'
    " Bundle 'Valloric/YouCompleteMe'  "补全神器，但macox下c的识别暂时配置有点问题
    " Bundle 'kien/rainbow_parentheses.vim'
    " Bundle 'Yggdroot/indentLine'
    " markdown 支持
      " Bundle 'godlygeek/tabular'
      " Bundle 'plasticboy/vim-markdown'
    " markdown 实时预览--国人写的，还不错挺好用的
      " Bundle 'iamcco/markdown-preview.vim'
    " Bundle 'tpope/vim-rails'
    " Bundle 'easymotion/vim-easymotion'
    " Bundle 'majutsushi/tagbar'
    " 主题 solarized
    " solarized
    " Bundle 'altercation/vim-colors-solarized'
    " molokai
    " 主题 molokai
    " Bundle 'tomasr/molokai'
    " 自动补全单引号，双引号等
    " Bundle 'Raimondi/delimitMate'
    " 自动补全html/xml标签
    " Bundle 'docunext/closetag.vim'

" desire:
    " 函数原型提示插件 -- 可能是echofunc
    " SrcExpl -- 调查， 传说像 source Insight
    "
    "Plugin 'godlygeek/csapprox' -- end
    "
    "Plugin 'henrik/vim-indexed-search' -- end
    "
    "Plugin 'tpope/vim-surround'
    "Plugin 'tpope/vim-fugitive'

" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:iswindows = 0
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" =============================================================================
"                          << 以下为vim配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if !g:iswindows
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配
    set nowrapscan " 禁止在搜索到文件两端时重新搜索

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        " set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set ttyfast                 "如果我们设置了ttyfast选项,Vim就会认为我们有一个比较快的终端连接,而且会改变输出来产生一个相对平滑的更新,但是这个有着更多的特征.如果我们有一个慢的连接,我们要重置这个选项
        " set backspace=2                " 设置退格键可用
        set backspace=indent,eol,start

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif


" set t_Co=256                   " 在终端启用256色
set nocompatible          "不要兼容vi
filetype off              "必须的设置：

" =============================================================================
"                          << 以下是相关插件配置 >>
" =============================================================================
" 修改leader键
let mapleader = ','
let g:mapleader = ','

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
" 用于更方便的管理vim插件，具体用法参考 :h vundle 帮助
" 安装方法为在终端输入如下命令
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

if !g:iswindows
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

" 使用Vundle来管理Vundle，这个必须要有。
Bundle 'gmarik/vundle'

" 以下为要安装或更新的插件，不同仓库都有（具体书写规范请参考帮助）
" 如何使用vundle来安装各个插件，分以下三种情况:
" vim-scripts repos  （vim-scripts仓库里的，按下面格式填写）
" Bundle 'a.vim'
" original repos on github（Github网站上非vim-scripts仓库的插件，按下面格式填写）
" Bundle 'jiangmiao/auto-pairs'
" non github repos   (非上面两种情况的，按下面格式填写)
" Bundle 'git://git.wincent.com/command-t.git'
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" -----------------------------------------------------------------------------
"  < 插件列表>
" -----------------------------------------------------------------------------

" 主题 solarized
" solarized
Bundle 'altercation/vim-colors-solarized'
" molokai
" 主题 molokai
Bundle 'tomasr/molokai'

" 文件搜索插件, 可用来替代Command-T
Bundle 'kien/ctrlp.vim'

" 代码注释插件
Bundle 'scrooloose/nerdcommenter'

" 关闭当前或指定buffer之外的其余buffer,实用的小plugin
Bundle 'BufOnly.vim'

" 有目录村结构的文件浏览插件
Bundle 'scrooloose/nerdtree'


" 在行号列中显示git diff标记的插件，只支持git --
Bundle 'airblade/vim-gitgutter'

" 用于保存文件是查检语法,个人觉得脚本语言用处更大
Bundle 'scrooloose/syntastic'

" 状态栏插件，更好的状态栏效果
" Bundle 'Lokaltog/vim-powerline'

" buf栏，输入F1，然后可以在列表中选择，比:ls方便
Bundle 'jlanzarotta/bufexplorer'

"自动补全end 括号的插件
Bundle 'tpope/vim-endwise'

"用于nerdtree的git显示插件 -- 国人开发的
Bundle 'Xuyuanp/nerdtree-git-plugin'

"单词高亮
Bundle 'vim-scripts/Mark--Karkat'

"undotree
Bundle 'mbbill/undotree'

" Track the engine.
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'

" 号称补全神器
Bundle 'Valloric/YouCompleteMe'
" Macos下安装步骤:
" 开启--clang-completer后，各种报错，暂时先不加--clang-completer了
" 1. vimrc中添加Bundle 'Valloric/YouCompleteMe'
" 2. vim中:BundleInstall
" 3. xcode-select --install; brew install cmake
" 3. 安装完毕后，cd ~/.vim/bundle/YouCompleteMe; ./install.py --clang-completer|--all

" Bundle 'rdnetto/YCM-Generator'

" 彩虹括号
Bundle 'kien/rainbow_parentheses.vim'

" 缩进线
Bundle 'Yggdroot/indentLine'

" markdown 支持
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'

" markdown 实时预览--国人写的，还不错挺好用的
Bundle 'iamcco/markdown-preview.vim'
" :MarkdownPreview 打开预览，:MarkdownPreviewStop, 关闭预览
" 支持实时更新，但需要vim支持py2/py3
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"  " mac下设置Chrome路径

" 用于rails标准目录models,controller,helper等等之类快速切换
Bundle 'tpope/vim-rails'

" 用于文件内快速跳转
Bundle 'easymotion/vim-easymotion'

" 不知道添加的了有啥用,官网描述也看不懂..但貌似大家都加了😂
Bundle 'vim-ruby/vim-ruby'

" 取代taglist,大纲式快速导航
Bundle 'majutsushi/tagbar'

" 自动补全单引号，双引号等
Bundle 'Raimondi/delimitMate'

" 自动补全html/xml标签
" Bundle 'docunext/closetag.vim'

" easyalign
" 快速赋值语句对齐
Bundle 'junegunn/vim-easy-align'

" 更高效的行内移动, f/F/t/T, 才触发
" quickscope
Bundle 'unblevable/quick-scope'

" 状态栏增强展示
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'

" signature
" 显示marks - 方便自己进行标记和跳转
" m[a-zA-Z] add mark
" '[a-zA-Z] go to mark
" m<Space>  del all marks
" m/        list all marks
Bundle 'kshenoy/vim-signature'

" 多光标选中编辑
" multiplecursors
Bundle 'terryma/vim-multiple-cursors'

" extended % matching for HTML, LaTeX, and many other languages
Bundle 'vim-scripts/matchit.zip'

" 快速加入修改环绕字符
" for repeat -> enhance surround.vim, . to repeat command
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'

Bundle 'elzr/vim-json'

" 自动格式化、标准化中文排版,
" 来源于 https://github.com/sparanoid/chinese-copywriting-guidelines
Bundle "hotoo/pangu.vim"


" bundle_start

" 还需要调查 ???shenhg
" Bundle 'vim-scripts/YankRing.vim'

" -----------------------------------------------------------------------------
"  < 各个插件配置 >
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'kien/ctrlp.vim' " 文件搜索插件, 可用来替代Command-T
  " 默认配置下，使用<c-p> 打开ctrlp插件
  " 以下为插件默认快捷键
  " Press <c-f> and <c-b> to cycle between modes ,就是在mru(Most Recently Used (MRU)),files,buf之间进行切换
  " <c-d> 只在文件名字查找
  " <c-r> 切换到正则表达式模式
  " <c-j>, <c-k> 在列表中进行上下文滚动
  " <c-t> 在新tab中打开文件
  " <c-x> 上下文分割
  " <c-v>  左右分割
  " <c-p>,<c-n> 查找历史搜索记录
  " <c-z> 用来选择/取消 选择的文件，<c-o> 来打开选择的文件
  " <c-w> 清除已经输入的文字
  " 设置忽略文件时，使用 vim自带的wildignore and CtrlP's own g:ctrlp_custom_ignore:
  "
  " let g:ctrlp_working_path_mode = 'ra'

  set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux"
  " let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|site_packages\|venv\|jupiter\/static\|jupiter\/template'
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'airblade/vim-gitgutter' " 在行号列中显示git diff标记的插件，只支持git --
  " 显示为~表明是修改，显示为+表明是增加，显示为-表明是删除
  " ]c 跳到下一个不同处
  " [c 跳到下一个不同处
  " <leader>hp 显示diff的preview
  " <leader>hs 将diff处提交为staged (s意为stage) -- 直接改写文件内容和文件的git状态，慎用
  " <leader>hr 将diff处恢复原状 (r意为revert) -- 直接改写文件内容和文件的git状态，慎用

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'scrooloose/nerdcommenter' " 代码注释插件
  " 以下为插件默认快捷键，其中的说明是以C/C++为例的
  " <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
  " <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
  " <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
  " <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
  " <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
  " <Leader>cA 行尾注释
  " <Leader>c$ 从光标处注释到行尾
  " <Leader>cs 以性感的方式进行注释，取消注释使用<Leader>cu
  " 避免麻烦，直接使用ci进行整行注释， 在行莫写注释用cA,
  " 如果要使用不同注释风格的话，使用ca进行切换
  "
  " 常用命令: <Leader>ci toggle注释
  let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'BufOnly.vim' " 关闭当前或指定buffer之外的其余buffer,实用的小plugin
  " :BufOnly without an argument will unload all buffers but the current one.
  " :BufOnly with an argument will close all buffers but the supplied buffer name/number.
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'scrooloose/nerdtree' " 有目录村结构的文件浏览插件
  " :ERDtree 打开NERD_tree :NERDtreeClose 关闭NERD_tree
  " o 打开关闭文件或者目录 t 在标签页中打开
  " T 在后台标签页中打开 ! 执行此文件
  " p 到上层目录 P 到根目录
  " K 到第一个节点 J 到最后一个节点
  " u 打开上层目录 m 显示文件系统菜单（添加、删除、移动操作）
  " r 递归刷新当前目录 R 递归刷新当前根目录"

  " 常规模式下输入 F2 调用插件
  nmap <F2> :NERDTreeToggle<CR>
  imap <F2> <ESC>:NERDTreeToggle<CR>
  " let NERDTreeIgnore += ['\.o$', '\.pyc$']    "添加不显示.o文件
  if exists("NERDTreeIgnore")
      let NERDTreeIgnore += ['\.o$', '\.pyc$']
  else
      let NERDTreeIgnore = ['\.o$', '\.pyc$']
  endif
  let NERDTreeIgnore += ['\.swp$', '\.$','\~$']
  let NERDTreeShowHidden=1                  "显示隐藏文件
  let NERDTreeShowLineNumbers=1             "显示行号
  " let NERDTreeShowBookmarks=1
  let g:NERDTreeMouseMode = 2
  " let g:NERDTreeWinSize = 40
  let g:NERDTreeChDirMode=2
  let g:NERDTreeMinimalUI=1
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'scrooloose/syntastic' " 用于保存文件是查检语法,个人觉得脚本语言用处更大
  let g:syntastic_check_on_open = 1 "打开文件时候就检查语法错误,默认不开启,为0
  let g:syntastic_check_on_wq = 0  "保存文件时候，进行语法错误检查，默认开启，为1
  let g:syntastic_ignore_files=[".*\.py$"] "设置忽略的文件类型,默认为[]
  let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd'] "设置某种文件类型的checkers，此处设置的是phpde，如果是phthon的话，则为g:syntastic_python_checkers
  "各种语法的check需要在vim/bundle/syntastic/syntax_checkers目录下去查看需要装何种类型的命令，比如.vim/bundle/syntastic/syntax_checkers/php目录下有php.vim，phpmd.vim，phpcs.vim三个文件，说明插件需要依赖php,phpmd或者phpcs命令来进行语法check
  " set statusline+=%#warningmsg#
  " set statusline+=%{SyntasticStatuslineFlag()}
  " set statusline+=%*
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'Lokaltog/vim-powerline' " 状态栏插件，更好的状态栏效果
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'jlanzarotta/bufexplorer' " buf栏，输入F1，然后可以在列表中选择，比:ls方便
  nnoremap <F1> :BufExplorer<cr>
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'tpope/vim-endwise' "自动补全end 括号的插件
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'Xuyuanp/nerdtree-git-plugin' "用于nerdtree的git显示插件 -- 国人开发的
" let g:NERDTreeIndicatorMapCustom = {  " 默认图标
    " \ "Modified"  : "✹",
    " \ "Staged"    : "✚",
    " \ "Untracked" : "✭",
    " \ "Renamed"   : "➜",
    " \ "Unmerged"  : "═",
    " \ "Deleted"   : "✖",
    " \ "Dirty"     : "✗",
    " \ "Clean"     : "✔︎",
    " \ "Unknown"   : "?"
    " \ }
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Bundle 'vim-scripts/Mark--Karkat'    "单词高亮
  " <Leader>m 标记高亮/取消高亮
  " <Leader>n 取消光标处的高亮，如果光标处没有高亮，则取消所有高亮
  " :Mark     取消全部高亮，但是有其余高亮时，还是会恢复
  " :MarkClear 取消所有高亮，标记信息也会被清除
  "
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
"undotree
" Bundle 'mbbill/undotree'
" :UndotreeToggle 打开所有的历史操作记录，挺酷的，但好像没用过这功能
  if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
  endif
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" 补全神器
" Bundle 'Valloric/YouCompleteMe'
  " let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
  " let g:ycm_server_use_vim_stdout = 1
  " let g:ycm_server_log_level = 'debug'
  let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
  let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
  let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
  let g:ycm_collect_identifiers_from_tags_files = 1
  " 开启语法关键字补全
  let g:ycm_seed_identifiers_with_syntax=1
  " 打开markdown, text文件的自动补全, 从g:ycm_filetype_blacklist 中删除markdown
  let g:ycm_filetype_blacklist = {
        \ 'tagbar' : 1,
        \ 'qf' : 1,
        \ 'notes' : 1,
        \ 'unite' : 1,
        \ 'text' : 1,
        \ 'vimwiki' : 1,
        \ 'pandoc' : 1,
        \ 'infolog' : 1,
        \ 'mail' : 1
        \}

  " <S-TAB> 同Raimondi/delimitMate的<S-TAB>映射会有冲突，导致没法使用，可以使用<UP>来替代，如果觉得不方便，可以设置为其他按键
  " defualt ['<S-TAB>', '<Up>']
  " let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']


" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
" Track the engine.
" Bundle 'SirVer/ultisnips'
  " UltiSnips triggering, avoid to the same trigger of YouCompleteMe
  " 避免和YouCompleteMe的tab建冲突，修改展开的快捷键为ctrl+j
  let g:UltiSnipsExpandTrigger = '<C-j>'
  let g:UltiSnipsJumpForwardTrigger = '<C-j>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 彩虹括号
" Bundle 'kien/rainbow_parentheses.vim'
" -----------------------------------------------------------------------------
" 官网推荐配置
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au VimEnter * RainbowParenthesesToggle
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 缩进线
" Bundle 'Yggdroot/indentLine'
" -----------------------------------------------------------------------------
" 用于显示对齐线，与 indent_guides 在显示方式上不同，根据自己喜好选择了
" 开启/关闭对齐线
nmap <leader>il :IndentLinesToggle<CR>

" 设置Gvim的对齐线样式
let g:indentLine_char = "│"
if g:isGUI
    let g:indentLine_char = "┊"
    let g:indentLine_first_char = "┊"
endif

" 设置终端对齐线颜色
let g:indentLine_color_term = 239
"
" 设置 GUI 对齐线颜色
" let g:indentLine_color_gui = '#A4E57E'
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" markdown 支持
" Bundle 'godlygeek/tabular'
" Bundle 'plasticboy/vim-markdown'
" -----------------------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1 " 设置为1禁用折叠
let g:vim_markdown_conceal = 0  " 禁止链接的隐藏功能，隐藏显示: [link text](link url) as just link text.
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" rails 支持
" Bundle 'tpope/vim-rails'
" -----------------------------------------------------------------------------
" vim-rails的详细说明文档: https://ruby-china.org/topics/19315
" gf跳转到对应的models，helper等等，ctrl+6跳转回来
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 文件内快速跳转
" Bundle 'easymotion/vim-easymotion'
" -----------------------------------------------------------------------------
"  中文详细说明: http://www.wklken.me/posts/2015/06/07/vim-plugin-easymotion.html
"  跳转前后位置: 快捷键<leader><leader>w(即,,w)和<leader><leader>b(即,,b)
"  搜索跳转: 快捷键<leader><leader>s(即,,s), 然后输入要搜索的字母, 这个跳转是双向的
"  行级跳转: 快捷键: <leader><leader>j和<leader><leader>k(即,,j和,,k)
"  行内跳转: 快捷键<leader><leader>h和<leader><leader>l(即,,h和,,l)
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 取代taglist,大纲式快速导航
" Bundle 'majutsushi/tagbar'
" -----------------------------------------------------------------------------
nmap <F9> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1
" 各个编程语言的支持,需要不同的设置，参考https://github.com/majutsushi/tagbar/wiki的说明
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 自动补全单引号，双引号等
" Bundle 'Raimondi/delimitMate'
" -----------------------------------------------------------------------------
" 触发后, 假设你要跳到补全后的符号后面继续编辑, 按Shift-Tab
" for python docstring ",优化输入
au FileType python let b:delimitMate_nesting_quotes = ['"']
au FileType php let delimitMate_matchpairs = "(:),[:],{:}"
" 关闭某些类型文件的自动补全
"au FileType mail let b:delimitMate_autoclose = 0

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 自动补全html/xml标签
" Bundle 'docunext/closetag.vim'
" -----------------------------------------------------------------------------
" 开启此插件时,黏贴xml,html的时候，千万别忘记设置:setlocal paste! 后在黏贴，否则可能会卡死
let g:closetag_html_style=1
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 快速赋值语句对齐
" Bundle 'junegunn/vim-easy-align'
" -----------------------------------------------------------------------------
"  v 选中区域，然后,a+对齐的符号， 例如以#对齐就是 ,a#
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 更高效的行内移动, f/F/t/T, 才触发
" quickscope
" Bundle 'unblevable/quick-scope'
" -----------------------------------------------------------------------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" todo ???颜色还需要另外设置一下
" let g:qs_first_occurrence_highlight_color = '#afff5f' " gui vim
let g:qs_first_occurrence_highlight_color = 155       " terminal vim

" let g:qs_second_occurrence_highlight_color = '#5fffff'  " gui vim
let g:qs_second_occurrence_highlight_color = 81         " terminal vim
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 状态栏增强展示
" Bundle 'vim-airline/vim-airline'
" Bundle 'vim-airline/vim-airline-themes'
" -----------------------------------------------------------------------------
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
" 修改airline theme为molokai, 当为tomorrow的theme时, 不是激活窗口的statusline一片漆黑
let g:airline_theme = 'molokai'
" let g:airline_theme = 'solarized'
" 是否打开tabline
" let g:airline#extensions#tabline#enabled = 1
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 多光标选中编辑
" multiplecursors
" Bundle 'terryma/vim-multiple-cursors'
" -----------------------------------------------------------------------------
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" ctrl-n选中后，可以a/c/x等等
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 快速加入修改环绕字符
" for repeat -> enhance surround.vim, . to repeat command
" Bundle 'tpope/vim-surround'
" -----------------------------------------------------------------------------
" 如下使用说明来源:http://www.wklken.me/posts/2015/06/13/vim-plugin-surround-repeat.html
" 版权归原作者
"    # 替换: cs"'
"    "Hello world!" -> 'Hello world!'
"
"    # 替换-标签(t=tag): cst"
"    <a>abc</a>  -> "abc"
"
"    cst<html>
"    <a>abc</a>  -> <html>abc</html>
"
"    # 删除: ds"
"    "Hello world!" -> Hello world!
"
"    # 添加(ys=you surround): ysiw"
"    Hello -> "Hello"
"
"    # 添加: csw"
"    Hello -> "Hello"
"
"    # 添加-整行: yss"
"    Hello world -> "Hello world"
"
"    # ySS"
"    Hello world ->
"    "
"        hello world
"    "
"
"    # 添加-两个词: veeS"
"    hello world -> "hello world"
"
"    # 添加-当前到行尾: ys$"
"
"    # 左符号/右符号 => 带不带空格
"    cs([
"    (hello) -> [ hello ]
"
"    cs(]
"    (hello) -> [hello]

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" Bundle 'elzr/vim-json'
" -----------------------------------------------------------------------------
"  取消双引号的隐藏
let g:vim_json_syntax_conceal = 0
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" 自动格式化、标准化中文排版,
" 来源于 https://github.com/sparanoid/chinese-copywriting-guidelines
" Bundle "hotoo/pangu.vim"
" -----------------------------------------------------------------------------
" 设置按照文档类型自动开启格式
  " autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing()
" 手动命令:
" :Pangu "手动执行该命令，将当前文件进行规范化。
" :PanguDisable "禁止自动规范化
" :PanguEnable "启用自动规范化
" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" config_end_flg

" =============================================================================
"                          << 以下是vim自身配置 >>
" =============================================================================
" 配置自己的leader命令为,避免同插件里面的\相冲突
" let mapleader = ","
" let g:mapleader = ","
" theme主题
set background=dark       " background=dark|light
set t_Co=256

" colorscheme molokai
" colorscheme solarized

"终端配色方案 -- 需要找一下https://github.com/chriskempson/tomorrow-theme
" colorscheme Tomorrow-Night-Eighties
colorscheme Tomorrow-Night-Bright  "best"
" colorscheme Tomorrow-Night

" colorscheme Tomorrow-Night-Blue  " -- discard
" colorscheme Tomorrow

" history存储容量
set history=2000
" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进

set smartindent                                       "启用智能对齐方式
set expandtab                                         "将Tab键转换为空格
set tabstop=4                                         "设置Tab键的宽度
set shiftwidth=4                                      "换行时自动缩进4个空格
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度的空格
set shiftround                                        "缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'"

set numberwidth=6          "行号栏的宽度

" 代码折叠 ???shenhg
" set foldenable                                        "启用折叠
"set foldmethod=indent                                 "indent 折叠方式
"" set foldmethod=marker                                "marker 折叠方式
"
"" 用空格键来开关折叠
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set ruler                               "设置标尺
set magic                               "用于正则转义时候, magic -> 使用正则搜索时，除了 $ . * ^ 之外其他元字符都要加反斜杠
set showmatch                           "插入括号时，短暂的跳到对应的括号处
set hidden                              "允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存

" 使用j/k的时候，光标以下最少显示的行数，即光标永远不会在最后一行
set scrolloff=7      "so = scrolloff

"在命令模式下使用 Tab 自动补全的时候，将补全内容使用一个漂亮的单行菜单形式显示出来, 超酷
set wildmenu

set autoread                            " 当文件在外部被修改，自动更新该文件

" 常规模式下输入 ,cS 清除行尾空格
nmap <leader>cS :%s/\s\+$//g<cr>:noh<cr>

" 常规模式下输入 ,cM 清除行尾 ^M 符号
nmap <leader>cM :%s/\r$//g<cr>:noh<cr>

set ignorecase                          "搜索模式里忽略大小写
set smartcase                           "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" set noincsearch                       "在输入要搜索的文字时，取消实时匹配

" 每行超过80个的字符用下划线标示 -- 基本不使用，显示器越来越大，80行显示是过时的设置了
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)


" -----------------------------------------------------------------------------
"  < 移动操作/窗口/buffer 的各种切换map>
" -----------------------------------------------------------------------------

" Fast saving
nmap <leader>w :w!<cr>

"  -----  插入模式下的上下行切换 ----------------
" Ctrl + K 插入模式下光标向上移动
imap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
imap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
imap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
imap <c-l> <Right>

" 映射j k 为软折行，在按j k时候，可以在自动换行的行数中上下
map j gj
map k gk

" 设置了wrap后，因为同一样会折行，因此会印象每一行的v:count的计数，单纯的map j gj，会将自动换行计数为大于一行，导致问题，采用如下方法解决，
" 参考:http://stackoverflow.com/a/21000307 https://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" 在不使用 MiniBufExplorer 插件时也可用<C-k,j,h,l>切换到上下左右的窗口中去
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" --- buffer 操作
" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" 使用方向键切换buffer
noremap <left> :bp<CR>
noremap <right> :bn<CR>

" Close all other buffers -- BufOnly.vim
" :BufOnly

" Useful mappings for managing tabs -- tabs基本不用，所以注释掉了
" map <leader>tn :tabnext<cr>
" map <leader>tp :tabprevious<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove<cr>

" 可能的一个tab操作，上面的不习惯了，可以换作下面这个
" nnoremap <C-TAB> :tabnext<CR>
" nnoremap <C-S-TAB> :tabprevious<CR>


" -----------------------------------------------------------
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
" 在Visual模式中，也可以使用*和#来搜索选中的文字，极其实用
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" -----------------------------------------------------------

" -----------------------------------------------------------------------------
"  < 各种文件类型的操作>
" -----------------------------------------------------------------------------

" 删除代码行后面多余的空格
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  " 老代码删除使用下面未注释的新代码
  " ====== old version start =======
  "特殊处理 加了plugin kshenoy/vim-signature后，同一行输入两次ma,第二次会取消a的mark，导致下面normal `z会出错，所以需要先加上normal dmz
  " exe "normal dmz"
  " exe "normal mz"
  " %s/\s\+$//ge
  " exe "normal `z"
  " ====== old version end =======
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunc

autocmd BufWrite * :call DeleteTrailingWS()   "所有文件都删除后面多余的空格
" autocmd BufWrite *.py :call DeleteTrailingWS()
" autocmd BufWrite *.coffee :call DeleteTrailingWS()
" autocmd BUfWrite *.c :call DeleteTrailingWS()
" autocmd BUfWrite *.cc :call DeleteTrailingWS()

" 对不同的文件设置不同的缩进
autocmd FileType ruby,vim setlocal tabstop=2 shiftwidth=2 softtabstop=2

" 设置markdown类型
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" 设置字典 -- 没使用，看是否有牛逼的插件可以来使用
" au FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
" au FileType css setlocal dict+=~/.vim/dict/css.dict
" au FileType c setlocal dict+=~/.vim/dict/c.dict
" au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
" au FileType scale setlocal dict+=~/.vim/dict/scale.dict
" au FileType javascript setlocal dict+=~/.vim/dict/javascript.dict
" au FileType html setlocal dict+=~/.vim/dict/javascript.dict
" au FileType html setlocal dict+=~/.vim/dict/css.dict

" -----------------------------------------------------------------------------
"  < 映射>
" -----------------------------------------------------------------------------
"一些不错的映射转换语法（如果在一个文件中混合了不同语言时有用）
" nnoremap <leader>1 :set filetype=xhtml<CR>
" nnoremap <leader>2 :set filetype=css<CR>
" nnoremap <leader>3 :set filetype=javascript<CR>
" nnoremap <leader>4 :set filetype=php<CR>


"切换拷贝模式
map <leader>pp :setlocal paste!<cr>

" disbale paste mode when leaving insert mode
" au InsertLeave * set nopaste

"使用tab键来代替%进行匹配跳转
nmap <tab> %
vmap <tab> %

"不要进入vim的Ex模式
nnoremap Q <nop>

"取消搜索高亮
nmap <leader>nh :noh<cr>

"系统剪切
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>p "+p
vmap <leader>p "+p

" 命令行模式增强，ctrl - a到行首， -e 到行尾
" cnoremap <C-j> <t_kd>
" cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>


" Fn快捷键映射
" F6 语法开关，关闭语法可以加快大文件的展示
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" Automatically set paste mode in Vim when pasting in insert mode
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            "显示行号
set relativenumber                                    "相对行号 要想相对行号起作用要放在显示行号后面

au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-m> :call NumberToggle()<cr>

set helplang=cn


set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set cursorline                                        "突出显示当前行
" set cursorcolumn                                      "突出显示当前列

" set title   "???jibing57
"

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
set t_ti= t_te=

set wrap                                                "设置自动换行
set shortmess=atI                                     "去掉欢迎界面


" 个性化状栏（这里提供两种方式，要使用其中一种去掉注释即可，不使用反之）<--
" 另外使用plugin
" let &statusline=' %t %{&mod?(&ro?"*":"+"):(&ro?"=":" ")} %1*|%* %{&ft==""?"any":&ft} %1*|%* %{&ff} %1*|%* %{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")} %1*|%* %=%1*|%* 0x%B %1*|%* (%l,%c%V) %1*|%* %L %1*|%* %P'
" set statusline=%t\ %1*%m%*\ %1*%r%*\ %2*%h%*%w%=%l%3*/%L(%p%%)%*,%c%V]\ [%b:0x%B]\ [%{&ft==''?'TEXT':toupper(&ft)},%{toupper(&ff)},%{toupper(&fenc!=''?&fenc:&enc)}%{&bomb?',BOM':''}%{&eol?'':',NOEOL'}]

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif




" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
set noswapfile                              "设置无临时文件
set vb t_vb=                                "关闭提示音

autocmd! bufwritepost _vimrc source %         "自动载入配置文件不需要重启

" set isk+=-                                  "将-连接符也设置为单词

" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif

" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清 -- 暂时没用过
" highlight clear SpellBad
" highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
" highlight clear SpellCap
" highlight SpellCap term=underline cterm=underline
" highlight clear SpellRare
" highlight SpellRare term=underline cterm=underline
" highlight clear SpellLocal
" highlight SpellLocal term=underline cterm=underline

" -----------------------------------------------------------------------------
"  < jibing57 coding 习惯配置 >
" -----------------------------------------------------------------------------


syntax on
" 设置对于xml和文本文件，语法关闭，避免打开文件卡顿, 如果需要，可以手动:syntax on 打开
autocmd FileType xml,text setlocal syntax=off

" highlight LineNr ctermfg=grey    " 配置行号为灰色"
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE    " 配置行号为灰色"
