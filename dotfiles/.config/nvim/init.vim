" BREAKING CHANGES: s is now sneak (use `cl` for `s`) function.
"                   <C-i> is now :bn (<C-i>==Tab for vim), use <C-p> for <C-i> function.
" Complete list of all vim commands: http://vimdoc.sourceforge.net/htmldoc/vimindex.html

"*** Load Plugins (uses vim-plug). ***"
try
  call plug#begin('~/.local/share/nvim/plugged')    " Load plugins with vim-plug.

  Plug 'AndrewRadev/splitjoin.vim'                  " gS to split, gJ to join lines.
  Plug 'ap/vim-buftabline'                          " Show buffers in the tab bar.
  Plug 'ap/vim-readdir'                             " Nicer file browser plugin that works with buftabline.
  Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', } " LSP Support (:h LanguageClient).
  Plug 'easymotion/vim-easymotion'                  " Go to any word instantly.
  Plug 'fweep/vim-zsh-path-completion'              " Nicer file browser plugin.
  Plug 'gibfahn/vim-gib'                            " Use vim colorscheme.
  Plug 'godlygeek/tabular'                          " Make tables easier (:help Tabular).
  Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --bin' } " :h fzf
  Plug 'junegunn/fzf.vim'                           " Try :Files, :GFiles? :Buffers :Lines :History :Commits :BCommits
  Plug 'junegunn/vim-peekaboo'                      " Pop up register list when pasting/macroing.
  Plug 'justinmk/vim-sneak'                         " sab -> go to next ab in code.
  Plug 'keith/swift.vim'                            " Swift syntax highlighting.
  Plug 'pangloss/vim-javascript'                    " JS   language bindings.
  Plug 'roxma/nvim-completion-manager'              " Completion plugin (used in LSP).
  Plug 'rust-lang/rust.vim'                         " Rust language bindings.
  Plug 'sjl/gundo.vim'                              " Interactive undo tree (<space>u to toggle on/off, q to quit).
  Plug 'tpope/vim-commentary'                       " Autodetect comment type for lang.
  Plug 'tpope/vim-fugitive'                         " Git commands in vim.
  Plug 'tpope/vim-repeat'                           " Allows you to use . with plugin mappings.
  Plug 'tpope/vim-surround'                         " Add/mod/remove surrounding chars.
  Plug 'tpope/vim-unimpaired'                       " [ and ] mappings (help unimpaired).

  call plug#end()                                   " Initialize plugin system
catch| echo 'vim-plug not installed, use :PI to install'
endtry

"*** Set vim options ***"
set nocompatible                                    " Remove vi compatibility hacks.
let mapleader = "\<Space>"                          " Set <Leader> (default shortcut used in mappings below) to Spacebar.

syntax on                                           " Turn on syntax highlighting.
filetype plugin indent on                           " Use file-specific plugins.
set shiftwidth=2 tabstop=2 softtabstop=2            " Set tab width to 2.
set expandtab                                       " Insert spaces when tab key pressed.
set backspace=indent,eol,start                      " Backspace works across lines.
set ignorecase                                      " Ignore case for lowercase searches,
set smartcase                                       "  ↳ don't for mixed-case.
set autoindent smartindent                          " Be more clever about indenting.
set gdefault                                        " Global replace default (off: /g).
set history=1000                                    " More command/search history.
set undolevels=1000                                 " More undo history.
set ruler                                           " Always show cursor position.
set showcmd                                         " Display incomplete commands.
set lazyredraw                                      " Don't redraw if you don't have to (e.g. in macros).
set incsearch                                       " Incremental searching.
set laststatus=2                                    " Always display the status line.
set hidden                                          " Don't force saving buffers on switching.
set textwidth=80                                    " Wrap at 79 chars (change: set tw=72).
set formatoptions-=t                                " Don't autowrap text at 80.
set autoread                                        " Auto read when file is changed elsewhere.
set nojoinspaces                                    " One space (not two) after punctuation..
set mouse=a                                         " Mouse in all modes (mac: Fn+drag = copy).
set number                                          " Turn on line numbers.
set numberwidth=5                                   " Width of line number buffer.
set hlsearch                                        " Highlight search matches (off: <Space>/).
colo gib                                            " Use my colorscheme
set ffs=unix                                        " Force Unix line endings (\n) (always show \r (^M), never autoinsert them).
set t_Co=256                                        " Use 256 color terminal.
set splitbelow                                      " Open new split panes to right and,
set splitright                                      "  ↳ bottom, which feels more natural.
set diffopt+=vertical                               " Always use vertical diffs.
set wildchar=<Tab> wildmenu                         " Tab complete with files (e.g. `:e`)
set wildmode=list:longest,list:full                 " 1st Tab completes to longest common string, 2nd+ cycles through options.
set list listchars=tab:»·,trail:·,nbsp:·            " Display extra whitespace.
if empty($XDG_CACHE_HOME)| let $XDG_CACHE_HOME = $HOME . '/.cache'| endif
let s:undodir = $XDG_CACHE_HOME . "/vim/undo"
if !isdirectory(s:undodir)| call mkdir(s:undodir, "p", 0700)| endif
set undofile                                        " Persist undo history on file close.
let &undodir=s:undodir                              " Store undo files in cache dir.
set path=.,/usr/include,,**                         " Add ** to the search path so :find x works recursively.
if exists('+breakindent')| set breakindent| let &showbreak = '↳ '| set cpo+=n| end " Nicer line wrapping for long lines.
if exists('&inccommand')| set inccommand=split| endif " Show search and replace as you type.
if exists("&wildignorecase")| set wildignorecase| endif " Case insensitive file tab completion with :e.

"*** Key mappings (see http://vim.wikia.com/wiki/Unused_keys for unused keys) ***"
" Available (normal): <C-Space>, K, +, _, <C-q/s/n/[/_>, <leader>b/c/e/h/m/n/s/u/v

inoremap          kj <ESC>|                         " kj = Esc in insert mode.
nnoremap          k gk|                             " Move up   visually , don't skip wrapped lines,
nnoremap          j gj|                             "  ↳   down visually , don't skip wrapped lines.
nnoremap          Q <nop>|                          "  ↳ accidental triggering).
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>| " Go to definition.
nnoremap          gk k|                             " Move up   logically, do    skip wrapped lines,
nnoremap          gj j|                             "  ↳   down logically, do    skip wrapped lines.
nnoremap <silent> gr :call LanguageClient_textDocument_rename()<CR>| " Rename var/func under cursor.
nnoremap          Y y$|                             " Make Y work like C and D (yank to end of line, not whole line).
" To open vim's current directory, use `:e .`.
nnoremap          - :e `dirname %`<CR>|             " - open current buffer directory in file browser (repeat for `cd ..`).
nmap              f <Plug>Sneak_f|                  " Use sneak for f (multiline+highlight).
nmap              F <Plug>Sneak_F|                  " ↳             F
nmap              t <Plug>Sneak_t|                  " ↳             t
nmap              T <Plug>Sneak_T|                  " ↳             T

nnoremap          <Leader>a @a<CR>|                 " Apply macro a (add with qa or yank to a reg with "ay).
nnoremap          <Leader>d :bp\|bd  #<CR>|         " Close buffer without closing split,
nnoremap          <Leader>D :bp\|bd! #<CR>|         "  ↳ Force close buffer.
nnoremap          <Leader>f :Files<CR>|             " Search file names    for file,
nnoremap          <Leader>F :grep |                 "  ↳          contents for file.
nnoremap          <Leader>gd :w !diff % - <CR>|     " Diff between saved file and current.
nnoremap          <Leader>gt :set et!<CR>:set et?<CR>|       " Toggle tabs/spaces.
nnoremap          <Leader>gq :set fo+=t<CR>:set fo?<CR>|     " Turn on  line wrapping,
nnoremap          <Leader>gQ :set fo-=t<CR>:set fo?<CR>|     "  ↳   off
nnoremap          <Leader>gv :e ~/.vimrc<CR>|       " <Space>gv opens this file in the editor (autoreloaded on save).
nnoremap          <Leader>gw :call Trim()<CR>|      " <Space>gw trims trailing whitespace for file.
nnoremap          <Leader>id :r !date +\%Y-\%m-\%d<CR>|      "  Insert readable    date on new line.
nnoremap          <Leader>iD :r !date +\%d-\%b-\%y<CR>|      "         `:sort`able date
nnoremap          <Leader>it ITODO(gib): <ESC>:Commentary<CR>$| " Insert a TODO, (Write todo, then `<Space>it`).
nnoremap          <Leader>j :sp<CR><C-w>k:bp<CR>|   " Open horizontal split,
nnoremap          <Leader>k <C-w>q|                 " Close current split (keeps buffer).
nnoremap <silent> <Leader>K :call LanguageClient_textDocument_hover()<CR>| " Show definition.
nnoremap          <Leader>l :vsp<CR><C-w>h:bp<CR>|  "  ↳   vertical split.
nnoremap          <Leader>o :on<CR>|                " Close all other buffers.
nnoremap          <Leader>p "+p|                    "  ↳                   (normal mode).
nnoremap          <Leader>P "+P|                    "  ↳  line from clipboard (normal mode).
nnoremap          <Leader>q :q<CR>|                 " Quit,
nnoremap          <Leader>Q :q!<CR>|                "  ↳ Quit losing unsaved changes.
nnoremap          <Leader>r :%s/|                   " Replace (e.g. <Space>rold/new),
nnoremap          <Leader>R :%s//c<Left><Left>|     "  ↳ Replace with prompt on each match.
map               <Leader>s <Plug>(easymotion-bd-w)|     " EasyMotion: Move to word.
nnoremap          <Leader>u :GundoToggle<CR>|       " Toggle Undo tree visualisation.
nnoremap          <Leader>w :up<CR>|                " Write if there were changes.
nnoremap          <Leader>W :w<CR>|                 "  ↳    whether or not there were changes.
nnoremap          <Leader>x :x<CR>|                 " Save (if changes) and quit.
nnoremap          <Leader>X :qa<CR>|                " Quit all windows.
nnoremap          <Leader>y "+y|                    " Copy to clipboard (normal mode).
nnoremap          <Leader>Y :%y+<CR>|               "  ↳  file to clipboard (normal mode).
nnoremap          <Leader>z  za|                    " Toggle folding on current line.
nnoremap <expr>   <Leader>Z &foldlevel ? 'zM' :'zR'| " See also "zi.
nnoremap          <Leader>/ :noh<CR>|               " Turn off find highlighting.
nnoremap          <Leader>? /<Up><CR>|              " Search for last searched thing.
nnoremap          <Leader><Tab> <C-^>|                    " Tab to switch to next buffer,

" Leader + window size keys increases/decreases height/width by 3/2.
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

vnoremap          <Leader>y "+y|                    "  ↳                (visual mode).
vnoremap          <Leader>d "+d|                    " Cut from clipboard (visual mode).
vnoremap          <Leader>p "+p|                    " Paste from clipboard (visual mode).

nnoremap          <C-h> <C-w>h|                     " Switch left  a window,
nnoremap          <C-j> <C-w>j|                     "  ↳     down  a window,
nnoremap          <C-k> <C-w>k|                     "  ↳     up    a window,
nnoremap          <C-l> <C-w>l|                     "  ↳     right a window.

nmap              <C-W>>     <C-W>><SID>ws|         " Adds mappings to make Ctrl-W -/+/</>
nmap              <C-W><     <C-W><<SID>ws|         " ↳ repeatable, so you can press Ctrl-W
nnoremap <script> <SID>ws>   <C-W>><SID>ws|         " ↳ and then hold > to increase width,
nnoremap <script> <SID>ws<   <C-W><<SID>ws|         " ↳ or hold - to decrease height.
nmap              <C-W>+     <C-W>+<SID>ws|         " ↳ Note that +,<, and > need the shift key.
nmap              <C-W>-     <C-W>-<SID>ws|         " ↳ Use <Leader> < or > for bigger
nnoremap <script> <SID>ws+   <C-W>+<SID>ws|         " ↳ modifications, and this for smaller
nnoremap <script> <SID>ws-   <C-W>-<SID>ws|         " ↳ tweaks.
nmap              <SID>ws    <Nop>

nnoremap          <Tab> :bn<CR>|                    " Tab to switch to next buffer,
nnoremap          <S-Tab> :bp<CR>|                  "  ↳ Shift-Tab to switch to previous buffer.
nnoremap          <C-p> <C-i>|                      " <C-o> = go to previous jump, <C-p> is go to next (normally <C-i>, but that == Tab, used above).
vnoremap          <expr> // 'y/\V'.escape(@",'\').'<CR>'|    " Search for selected text with // (very no-magic mode, escaped backslashes).

" Open the selected text with the appropriate program (like netrw-gx).
nnoremap          <Leader>o :set operatorfunc=OpenUrl<CR>g@
vnoremap          <Leader>o :<c-u>call OpenUrl(visualmode())<CR>

" Used with `<Leader>o` mappings.
function! OpenUrl(type)
  if a:type ==# 'v'| execute "normal! `<v`>y"
  elseif a:type ==# 'char'| execute "normal! `[v`]y"
  else| return
  endif

  " This doesn't work with macOS /usr/bin/vim (doesn't identify as macOS).
  if has('mac')| let openCmd = 'open'| else| let openCmd = 'xdg-open'| endif
    silent execute "! " . openCmd . " " . shellescape(@@, 1)
    echo openCmd . " " shellescape(@@, 1)
endfunction

if has("nvim")                                      " NeoVim specific settings.
  let g:terminal_scrollback_buffer_size = 100000    " Store lots of terminal history.
  if executable("nvr")| let $VISUAL = 'nvr --remote-wait'| endif " Use existing nvim window to open new files (e.g. `g cm`).
  nnoremap <Leader>t :vsplit term://$SHELL<CR>i|    " Open terminal in new split.
  nnoremap <Leader>T :term<CR>|                     " Open terminal in current split.
  tnoremap <C-h> <C-\><C-n><C-w>h|                  " Switch left  a window in terminal,
  tnoremap <C-j> <C-\><C-n><C-w>j|                  "  ↳     down  a window in terminal,
  tnoremap <C-k> <C-\><C-n><C-w>k|                  "  ↳     up    a window in terminal,
  tnoremap <C-l> <C-\><C-n><C-w>l|                  "  ↳     right a window in terminal.
  tnoremap <Esc> <C-\><C-n>|                        " Make Escape work in terminal,
  tnoremap kj <C-\><C-n>|                           "  ↳    kj    work in terminal.

  augroup gibNvimGroup                              " Autocommands for nvim only
  au TermOpen * setlocal nonumber norelativenumber  " No line numbers in terminal
  augroup end
endif

"*** Custom Commands ***"
command! W w !sudo tee % > /dev/null|               " :W saves file as sudo.
command! Trim call TrimWhitespace()|                " :Trim runs :call Trim() (defined below).
command! PU PlugClean | PlugUpdate | PlugUpgrade|   " :PI installs vim-plug, :PU updates/cleans plugins and vim-plug.
command! PI !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &&
    \ ln -s ~/.local/share/nvim/site/autoload ~/.vim/autoload

let g:is_posix = 1                                  " Assume shell for syntax highlighting.
"let g:rustfmt_autosave = 1                         " Run rustfmt on save (from rust.vim).
let g:sneak#use_ic_scs = 1                          " Sneak: respect smartcase setting.
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1                        " Don't use the built-in file browser (use vim-readdir instead).
let g:peekaboo_window = "vert bo 50new"             " Increase peekaboo window width to 50.
let g:gundo_right = 1                               " Undo window on right.
let g:gundo_preview_bottom = 1                      " Undo diff preview on bottom.
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'swift': ['langserver-swift'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }

" Highlight the 81st column of text (in dark grey so it doesn't distract).
highlight ColorColumn ctermbg=234
call matchadd('ColorColumn', '\%81v', 100)

set path=.,/usr/include,,**                         " Add ** to search path
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading         " Use ripgrep for file searching.
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

augroup gibAutoGroup                                " Group of automatic functions.
  au!
  au BufReadPost *|                                 " On open jump to last cursor position if possible.
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  au BufRead,BufNewFile *.md set filetype=markdown  " Use markdown for md files.
  au FileType help wincmd L                         " Open new help windows on the right,
"  au FileType qf wincmd L                           "  ↳       build windows on the right.
  au BufWritePost .vimrc so $MYVIMRC|               " Reload .vimrc on save.
  au BufWritePost init.vim so $MYVIMRC|             " Reload init.vim (nvim) on save.
augroup END

set wildmode=list:longest,list:full                 " Insert tab at beginning of line or after whitespace,
function! InsertTabWrapper()                        "  ↳ else use completion.
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\S'| return "\<tab>"| else| return "\<c-n>"| endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>|        " Tab is autocomplete unless at beginning of line.
inoremap <S-Tab> <c-p>|                             " Shift-Tab is always autocomplete.


" Function to trim trailing whitespace in a file.
function! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun
