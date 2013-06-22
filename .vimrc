"文字コード設定================
	set fileencoding=utf-8
	"set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932
	set fileencodings=utf-8
	

"システム設定==================
        "without vi compatibility
		set nocp

		"available filetype recognization
		filetype plugin on

		"omni completion setting
		let OmniCpp_DefaultNamespace = ["std", "_GLIBCXX_STD"]
		autocmd CursorMovedI * if pumvisible() == 0|pclose|endif 
		autocmd InsertLeave * if pumvisible() == 0|pclose|endif 
		imap <C-N> <C-X><C-O>

		"バックアップファイルを決まったディレクトリに作りたい
        "set backupdir=/home/hayama/.vimbackup
        "↑適当なディレクトリに書き換えて手前の「"」を外して使う
 
        "viminfoを決まったディレクトリに作りたい
        "set viminfo+=nC:/hoge/hoge/.viminfo
        "↑適当なディレクトリに書き換えて手前の「"」を外して使う
 
        "javaのクラス名に色をつける(javaid.vimがあるとなお良し)
        let java_highlight_all=1
        let java_highlight_debug=1
        let java_highlight_functions=1
 "編集設定=====================
        "検索時に大文字小文字を考慮しない
        set ignorecase
 
        "Tab文字を画面上の見た目で何文字幅にするか設定
        set tabstop=4
         "自動で挿入されるタブの幅
        set shiftwidth=4
 
        "タブの代わりに空白をいれるときの空白数。0だと無効。
        set softtabstop=0
 
        "検索時にインクリメンタルサーチ
        set incsearch
 "表示関連========================
        "行番号をつける
        set number
 
        "画面端で折り返さない
        set nowrap
 
        "タブを>----で表示
        "set listchars=tab:>-
        "set list
 
        "タブを>    で表示
        "set listchars=tab:>\ 
        "set list
 
        "タイトルバーにファイル名を表示
        set title
 
        "ルーラを表示
        set ruler
 
        "入力中のコマンドをステータスに表示
        set showcmd
 
        "スクロールするとき上下に余裕を確保する
        set scrolloff=5

		"ハイライトをEsc連打で無効に
		nmap <Esc><Esc> :nohlsearch<CR><Esc>

 "ステータス部関連==================
        "ステータス部分を2行に
        set laststatus=2
 
        "ステータス部の書式設定(詳細は後述)
        set statusline=%y%{GetStatusEx()}%F%m%r%=<%l-%c(%p%%)>
 
        " 文字エンコーディング＆改行コード取得関数。
        " 某所からのパクリ。
        " http://www.seeds-man.com/~nari/v2/people/nari/comp/linux/vim1.shtml
        function GetStatusEx()
        "function! GetStatusEx()
                let str = ''
                let str = str . '' . &fileformat . ']'
                if has('multi_byte') && &fileencoding != ''
                        let str = '[' . &fileencoding . ':' . str
                endif
                return str
        endfunction
 
 "色関連=========================-
 "      使用できる色は
 "              :edit $VIMRUNTIME/syntax/colortest.vim
 "              :source %
 "      で、設定名と現在の色は
 "              :highlight
 "      で確認できます。
 "      cterm は色が使える端末を意味するらしい
 
        "色をつける
       " syntax on
 
        "ステータス部の色設定?
        highlight StatusLine cterm=NONE ctermfg=white ctermbg=black
 
        "行番号の色
        highlight LineNr ctermfg=red
 
        "特殊記号
        highlight SpecialKey ctermfg=grey
 
        "見出語やキーワードなど
        highlight Statement ctermfg=blue 
 
        "特殊な語など
        highlight Identifier ctermfg=darkblue 
 
        "コメント
        highlight Comment ctermfg=darkred
 
        "型"
        highlight Type ctermfg=darkgreen

        " 長い行を折り返して表示 (nowrap:折り返さない)
        set wrap

"20061124追加分

        " タブの画面上での幅
        set tabstop=4
        " タブをスペースに展開しない (expandtab:展開する)
        set noexpandtab
        " 自動的にインデントする (noautoindent:インデントしない)
        set autoindent
        " 自動インデント幅
        set shiftwidth=4
        " タブをスペースn個で表現
        set softtabstop=4
        " バックスペースでインデントや改行を削除できるようにする
        set backspace=2
        " 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
        set wrapscan
        " 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
        set showmatch

        " Cプログラムの自動インデント
        set cindent
         " コマンドライン補完する
        set wildmenu

        set smartindent

        
