if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/neosnippet' )
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/vimproc.vim',{'build' : 'make'})
call dein#add('osyo-manga/vim-monster')
call dein#add('Shougo/vimshell')
call dein#add('thinca/vim-quickrun')
call dein#add('thinca/vim-ref')
call dein#add('vim-scripts/gtags.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('dag/vim2hs')
call dein#add('ujihisa/neco-ghc')
call dein#add('tpope/vim-endwise')
call dein#add('tpope/vim-rails')
call dein#add('sophacles/vim-processing')
call dein#add('kannokanno/previm')
call dein#add('vimscripts/open-browser.vim')
call dein#add('derekwyatt/vim-scala')
call dein#add('elixir-lang/vim-elixir')
call dein#add('slim-template/vim-slim')
" syntax checker
call dein#add('neomake/neomake')
call dein#add('benjie/neomake-local-eslint.vim')
" coffee-scirptsyntax + 自動compile
call dein#add('kchmck/vim-coffee-script')
call dein#add('othree/yajs.vim')
" カラースキーム
call dein#add('altercation/vim-colors-solarized')

call dein#end()

" ファイル名と内容によってファイルタイプを判別し、ファイルタイププラグインを有効にする
filetype plugin indent on


"プラグイン系 設定
""" unite.vim
" 入力モードで開始する
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" grep検索
nnoremap <silent> ,ug  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" using ag for unite
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif

augroup Unite
    autocmd!
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    autocmd FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
    autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
augroup END

" unite-grep keymap
vnoremap ,ug y:Unite grep::-iRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>

" neocomplete
let g:neocomplete#enable_at_startup = 1 " 起動時に有効化
let g:neocomplete#enable_underbar_completion = 1 " _の補完を有効化

" neosnippet 
" スニペット呼び出し
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
"プレビュー
set completeopt-=preview

" monster
" Set async completion.
" Use neocomplete.vim
let g:neocomplete#sources#omni#input_patterns = {
            \   "ruby" : '[^. *\t]\.\w*\|\h\w*::',
            \}

" vimshell setting
let g:vimshell_interactive_update_time = 10

" vimshell map
nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>

"lightline
"colorschemeをsolarized
let g:lightline = {
            \ 'colorscheme' : 'solarized' ,
            \}

"quickrunでprocessingを実行
let g:quickrun_config = {}
let g:quickrun_config.processing =  {
            \     'command': 'processing-java',
            \     'exec': '%c --sketch=$PWD/ --output=~/Library/Processing --run --force'
            \   }
"gtags.vim
map <C-j> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-p> :cp<CR>

"neomake
let g:neomake_ruby_enabled_makers=['rubocop']
let g:neomake_scss_enabled_makers=['scsslint']
let g:neomake_javascript_enabled_makers=['eslint']
augroup SyntaxCheck
    autocmd!
    autocmd BufWritePost * Neomake
augroup END


"色付け
syntax on

" カラースキーマを Solarized にする
colorscheme solarized
set background=light

" エンコーディングをutf-8
set encoding=utf-8
" 読み込みエンコーディング
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

"パーシスタントundo
if has('persistent_undo')
    set undodir=~/.vim/.vimundo
    set undofile
endif

"テンプレ設定
augroup Template
    autocmd!
    autocmd BufNewFile *.tex 0r ~/.vim/templates/tex.tex "texのテンプレ
    autocmd BufNewFile *.sh 0r ~/.vim/templates/sh.sh "shのテンプレ
    autocmd BufNewFile *.py 0r ~/.vim/templates/python.py "pythonのテンプレ
augroup END


" バッファを保存しなくても他のバッファを表示できるようにする
set hidden

" コマンドライン補完を便利に
set wildmenu

" タイプ途中のコマンドを画面最下行に表示
set showcmd

" 検索語を強調表示（<C-L>を押すと現在の強調表示を解除する）
"set hlsearch

"インクリメンタルな検索を行う
set incsearch

" 検索時に大文字・小文字を区別しない。ただし、検索後に大文字小文字が
" 混在しているときは区別する
"set ignorecase
"set smartcase

" オートインデント、改行、インサートモード開始直後にバックスペースキーで
" 削除できるようにする。
set backspace=indent,eol,start

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" 画面最下行にルーラーを表示する
set ruler

" ステータスラインを常に表示する
set laststatus=2

" バッファが変更されているとき、コマンドをエラーにするのでなく、保存する
" かどうか確認を求める
set confirm

" ビープの代わりにビジュアルベル（画面フラッシュ）を使う
set visualbell

" そしてビジュアルベルも無効化する
set t_vb=

" 全モードでマウスを有効化
set mouse=a

" コマンドラインの高さを2行に
set cmdheight=1

" 行番号を表示
"set number

" 相対番号を表示
" set relativenumber

" キーコードはすぐにタイムアウト。マッピングはタイムアウトしない
set notimeout ttimeout ttimeoutlen=200

" <F11>キーで'paste'と'nopaste'を切り替える
"set pastetoggle=<F11>

" オートインデント
set autoindent

" インデント時の空白数
set shiftwidth=4

" tabキーの空白の数
set softtabstop=4

" tabキーの代わりに半角スペースを使う
set expandtab

" タブ文字を文字分の幅で表示する。
set tabstop=4

" マッピング
" Yの動作をDやCと同じにする
map Y y$

" <C-L>で検索後の強調表示を解除す
nnoremap <C-L> :nohl<CR><C-L>
