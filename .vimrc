"##############################################################################
"################################## Plugins ###################################
"##############################################################################
"==============================================================================
" Use vim-plug to install plugins
"==============================================================================
"
" Download plug.vim and put it in ~/.vim/autoload
"
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Edit your .vimrc
"
"   call plug#begin('~/.vim/plugged')
"
"   " Make sure you use single quotes
"
"   " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"   Plug 'junegunn/vim-easy-align'
"
"   " Any valid git URL is allowed
"   Plug 'https://github.com/junegunn/vim-github-dashboard.git'
"
"   " Multiple Plug commands can be written in a single line using | separators
"   Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"
"   " On-demand loading
"   Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"   Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"
"   " Using a non-master branch
"   Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
"
"   " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"   Plug 'fatih/vim-go', { 'tag': '*' }
"
"   " Plugin options
"   Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
"
"   " Plugin outside ~/.vim/plugged with post-update hook
"   Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"
"   " Unmanaged plugin (manually installed and updated)
"   Plug '~/my-prototype-plugin'
"
"   " Initialize plugin system
"   call plug#end()
"
" Then reload .vimrc and :PlugInstall to install plugins.
"
" Plug options:
"
"| Option                  | Description                                      |
"| ----------------------- | ------------------------------------------------ |
"| `branch`/`tag`/`commit` | Branch/tag/commit of the repository to use       |
"| `rtp`                   | Subdirectory that contains Vim plugin            |
"| `dir`                   | Custom directory for the plugin                  |
"| `as`                    | Use different name for the plugin                |
"| `do`                    | Post-update hook (string or funcref)             |
"| `on`                    | On-demand loading: Commands or `<Plug>`-mappings |
"| `for`                   | On-demand loading: File types                    |
"| `frozen`                | Do not update unless explicitly specified        |

"------------------------------------------------------------------------------
" Automatic installation
"------------------------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"------------------------------------------------------------------------------

call plug#begin('~/.vim/plugged')
"######################### Colorthemes and Appearance #########################

" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" A vim color scheme based on the Railscasts Textmate theme
"Plug 'jpo/vim-railscasts-theme'

" Molokai color scheme for Vim
"Plug 'tomasr/molokai'

"Retro groove color scheme for Vim
Plug 'morhetz/gruvbox'

" Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP,
" unite, Denite, lightline, vim-startify and many more
Plug 'ryanoasis/vim-devicons'

" Enhanced terminal integration for Vim
" Cursor shape change in insert and replace mode
Plug 'wincent/terminus'

" This plugin is used for displaying thin vertical lines at each indentation
" level for code indented with spaces.
Plug 'Yggdroot/indentLine'

" A Vim plugin which shows a git diff in the 'gutter' (sign column).
Plug 'airblade/vim-gitgutter'

" Make the yanked region apparent!
Plug 'machakann/vim-highlightedyank'

"#################################### Tools ###################################

" A command-line fuzzy finder for Vim.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Enhanced multi-file search for Vim.
Plug 'wincent/ferret'

" Surround.vim is all about "surroundings": parentheses, brackets,
" quotes, XML tags, and more. The plugin provides mappings to easily delete,
" change and add such surroundings in pairs.
Plug 'tpope/vim-surround'

" Supercharges Vim's . command (. repeats the last change you made) and allows
" for plugins to hook into the . command.
Plug 'tpope/vim-repeat'

" Comment stuff out.
Plug 'tpope/vim-commentary'

" The best Git wrapper of all time.
Plug 'tpope/vim-fugitive'

" Automatically create any non-existent directories before writing the buffer.
Plug 'pbrisbin/vim-mkdir'

call plug#end()

"##############################################################################
"################################# Functions ##################################
"##############################################################################
"==============================================================================
" Delete unwanted whitespaces
"==============================================================================
" :%s/\s\+$//e
"
" :%s to run :substitute over the range %, which is the entire buffer.
" \s t match all whitespace characters.
" \+ to repeat them 1 or more times.
" $ to anchor at the end of the line.
" The e flag to not give an error if there is no match
" (i.e. the file is already without trailing whitespace).
"
" 1. We save & restore the cursor position.
" 2. The last-used search term is automatically restored after leaving a
"    function, so we don't have to do anything else for this.
function! TrimWhitespace()
  let l:save_cursor = getpos('.')
  %s/\s\+$//e
  call setpos('.', l:save_cursor)
endfunction

"==============================================================================
" Toggle relative numbering
"==============================================================================
function! RelativeNumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunction

"##############################################################################
"################################## Settings ##################################
"##############################################################################
set encoding=utf-8     " Use UTF-8 encoding.
" Length of time waits after stop typing (default: 4000 millisec.).
"set updatetime=750
set number             " Show the line numbers on the left side.
set colorcolumn=80     " Show a vertical line at 80th character.
" Tell Vim which characters to show for expanded TABs.
set listchars=eol:¬,tab:>.,trail:~,extends:>,precedes:<,space:.
set list               " Show hidden characters.
set nowrap             " Don't wrap lines.
" For indentation without tabs, the principle is to set 'expandtab', and set
" 'shiftwidth' and 'softtabstop' to the same value, while leaving 'tabstop' at
" its default value.
set expandtab          " Insert spaces when TAB is pressed.
set shiftwidth=2       " Indentation amount for < and > commands.
set softtabstop=2      " What happens when you press the <TAB> or <BS> keys.
"set tabstop=2         " Changes the width of the TAB character.
set autoindent         " Automatically indent the next line.
set smartindent        " Smart indent the next line, racts to the
                       " syntax/style of the code.
if !&scrolloff
  set scrolloff=3      " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5  " Show next 5 columns while side-scrolling.
endif
set nostartofline      " Do not jump to first character with page commands.
set ignorecase         " Make searching case insensitive...
set smartcase          " ... unless the query has capital letters.
set mouse=a            " Set mouse with all previous mode.
set termguicolors      " Enable TrueColor. It needs export TERM=xterm-256color
set hlsearch           " Highlighting search matches.
set wildmenu           " Display all matching things when press TAB to complete

" Map the leader key to SPACE.
let mapleader="\<Space>"

" Store temporary files in a central spot.
let vimtmp = $HOME . '/.vim/tmp/' . getpid()
silent! call mkdir(vimtmp, "p", 0700)
let &backupdir=vimtmp
let &directory=vimtmp

"==============================================================================
" netrw
"==============================================================================
" 0: Thin, one file per line
" 1: Long, one file per line with file size and time stamp
" 2: Wide, which is files in columns
" 3: Tree style
let g:netrw_liststyle=3

"############################## Function configs ##############################

"==============================================================================
" TrimWhitespace
"==============================================================================
" Trim automatically when before save the file.
autocmd BufWritePre * :call TrimWhitespace()

"############################### Plugin configs ###############################

"==============================================================================
" vim-airline
"==============================================================================
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
"let g:airline_theme='molokai'

" This config fix the build in terminal powerline problems.
"if !exists('g:airline_symbols')
"  let g:airline_symbols={}
"endif
" Unicode symbols.
"let g:airline_left_sep='▶'
"let g:airline_right_sep='◀'
"let g:airline_symbols.crypt='🔒 '
"let g:airline_symbols.linenr='␊'
"let g:airline_symbols.maxlinenr='☰'
"let g:airline_symbols.branch='⎇'
"let g:airline_symbols.paste='∥'
"let g:airline_symbols.spell='Ꞩ'
"let g:airline_symbols.notexists='∄'
"let g:airline_symbols.whitespace='Ξ'

"------------------------------------------------------------------------------
" airline-branch (using vim-fugitive)
"------------------------------------------------------------------------------
" enable/disable fugitive/lawrencium integration
let g:airline#extensions#branch#enabled=1

" Change the text for when no branch is detected >
"let g:airline#extensions#branch#empty_message = ''

" Truncate long branch names to a fixed length >
"let g:airline#extensions#branch#displayed_head_limit = 10

" Customize formatting of branch name
" default value leaves the name unmodifed:                               0
" to only show the tail, e.g. a branch 'feature/foo' becomes 'foo', use: 1
" to truncate all path sections but the last one, e.g.
" a branch 'foo/bar/baz' becomes 'f/b/baz', use:                         2
let g:airline#extensions#branch#format=1

"==============================================================================
" gruvbox
"==============================================================================
colorscheme gruvbox
set background=dark

"==============================================================================
" vim-highlightedyank
"==============================================================================
highlight HighlightedyankRegion cterm=reverse gui=reverse

"==============================================================================
" indentLine
"==============================================================================
"let g:indentLine_enabled=0
"let g:indentLine_setColors=0
"let g:indentLine_char='┊'
"let g:indentLine_color_term=239
let g:indentLine_color_gui='#504945'

"==============================================================================
" fzf.vim
"==============================================================================
" Customize fzf colors to match your color scheme
let g:fzf_colors=
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"" --column:       Show column number
" --line-number:   Show line number
" --no-heading:    Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case:   Case insensitive search
" --no-ignore:     Do not respect .gitignore, etc...
" --hidden:        Search hidden files and folders
" --follow:        Follow symlinks
" --glob:          Additional conditions for search
"                  (in this case ignore everything in the .git/ folder)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always ' .
  \   '--colors "path:fg:108" --colors "line:fg:109" --smart-case '
  \   .shellescape(<q-args>), 1, { 'options': '--color hl:214,hl+:214' }, 0)

let g:fzf_action={
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }
let g:fzf_layout={ 'down': '~60%' }

"##############################################################################
"################################## Mappings ##################################
"##############################################################################
"------------------------------------------------------------------------------
" To move the cursor, press the h,j,k,l keys as indicated.
"------------------------------------------------------------------------------
"             ^
"             k
"       < h       l >
"             j
"             v

"------------------------------------------------------------------------------
" To move horizontally
"------------------------------------------------------------------------------
"| Mapping | Operation                                                        |
"|---------|------------------------------------------------------------------|
"| w       | Jump from one word to the next one (as in (w)ord).               |
"| b       | Jump from one word to the next one backwards (as in (b)ack).     |
"| e       | Jump to the end of the next word (as in (e)nd).                  |
"| ge      | Jump to the end of the next word backwards.                      |
"| f<char> | Find the next occurrence of a character in the line you are in.  |
"|         | Places the cursor on top of the character you want to find.      |
"| F<char> | Same as above just backwards.                                    |
"| t<char> | Like f just places the cursor before of the character you want   |
"|         | to find.                                                         |
"| T<char> | Same as above just backwards.                                    |
"| ;       | After to find an occurrence then go to the next one.             |
"| ,       | After to find the next occurrence then go to the previous one.   |
"| 0       | Moves to the first character of a line.                          |
"| ^       | Moves to the first non-blank character of a line (so it would    |
"|         | exclude the indentation of a line of code for instance).         |
"| $       | Moves to the end of a line.                                      |
"| g_      | Moves to the non-blank character at the end of a line.           |

"------------------------------------------------------------------------------
" To move vertically
"------------------------------------------------------------------------------
"| Mapping    | Operation                                                     |
"|------------|---------------------------------------------------------------|
"| }          | Jump paragraphs forwards.                                     |
"| {          | Jump paragraphs backwards.                                    |
"| /<pattern> | Search a pattern forwards.                                    |
"| ?<pattern> | Search a pattern backwards.                                   |
"| *          | Search a pattern under the cursor.                            |
"| n          | After to find a pattern then jump to the next one.            |
"| N          | After to find the next pattern then jump to the previous one. |

"------------------------------------------------------------------------------
" Go to definition using g
"------------------------------------------------------------------------------
"| Mapping     | Operation                                                    |
"|-------------|--------------------------------------------------------------|
"| gd          | Will take you to the local declaration.                      |
"| gD          | Will take you to the global declaration.                     |
"| g*          | Search for the word under the cursor (like *, but g* on      |
"|             |'rain' will find words like 'rainbow').                       |
"| g#          | Same as g* but in backward direction.                        |
"| gg          | Goes to the first line in the buffer (or provide a count     |
"|             | before the command for a specific line).                     |
"| gg<action>G | Perform actions on a whole file.                             |
"| <count>gg   | Sends you to a specific code line within a file.             |
"| G           | Goes to the last line (or provide a count before the command |
"|             | for a specific line).                                        |
"| gf          | Will go to the file under the cursor                         |
"| g]          | and other commands will jump to a tag definition (a tag can  |
"|             | be a function or variable name, or more).                    |

"------------------------------------------------------------------------------
" Editing text
"------------------------------------------------------------------------------
"
" <count><action><motion or text-object>
"
" Actions: (d)elete, (c)hange, (y)ank
" Motions: h, j, k, l, w, etc.
" Text-objects:
"   a: represents the text object plus whitespace
"   i: inner object without whitespace
"   w: for word
"   s: for sentence
"   ' ": for quotes
"   p: for paragraph
"   b: for block surrounded by (
"   B: for block surrounded by {
"   t: for tag
"
"| Mapping            | Operation                                             |
"|--------------------|-------------------------------------------------------|
"| <action>l          | (d)elete/(c)hange/(y)ank one (or more with count)     |
"|                    | letter (e.g. dl or 5dl).                              |
"| <action>h          | (d)elete/(c)hange/(y)ank one (or more with count)     |
"|                    | letter before the cursor (e.g. dh or 5dh).            |
"| <action>j          | (d)elete/(c)hange/(y)ank the current line and one     |
"|                    | (or more with count) line below (e.g. dj or 5dj).     |
"| <action>k          | (d)elete/(c)hange/(y)ank the current line and one     |
"|                    | (or more with count) line above (e.g. dk or 5dk).     |
"| <action>f'         | (d)elete/(c)hange/(y)ank everything in the current    |
"|                    | line until the first occurrence of the ' (e.g. df').  |
"| <action>t'         | (d)elete/(c)hange/(y)ank everything in the current    |
"|                    | line until the first occurrence of the ', but         |
"|                    | excluding ' (e.g. dt').                               |
"| <action>/<pattern> | (d)elete/(c)hange/(y)ank everything until the first   |
"|                    | occurrence of pattern (e.g. d/hello).                 |
"| gg<action>G        | (d)elete/(c)hange/(y)ank the copmlete document        |
"|                    | (e.g. ggdG).                                          |
"| <action><action>   | (d)elete/(c)hange/(y)ank the current line             |
"|                    | (e.g. dd or 5dd).                                     |
"| <ACTION>           | (D)elete/(C)hange/(Y)ank from the cursor to the end   |
"|                    | of the line (e.g. D).                                 |
"| <action>aw         | (d)elete/(c)hange/(y)ank a word plus the trailing     |
"|                    | whitespace (e.g. daw).                                |
"| <action>iw         | (d)elete/(c)hange/(y)ank inner word (e.g. diw).       |
"| <action>as         | (d)elete/(c)hange/(y)ank a sentence (e.g. das).       |
"| <action>is         | (d)elete/(c)hange/(y)ank inner sentence (e.g. dis).   |
"| <action>a"         | (d)elete/(c)hange/(y)ank something in double quotes   |
"|                    | including the quotes. (e.g. da").                     |
"| <action>i"         | (d)elete/(c)hange/(y)ank something inside double      |
"|                    | quotes (e.g. di").                                    |
"| <action>ap         | (d)elete/(c)hange/(y)ank a paragraph (e.g. dap).      |
"| <action>ab/a(/a)   | (d)elete/(c)hange/(y)ank a block surrounded by (      |
"|                    | (e.g. dab, da( or da) ).                              |
"| <action>aB/a{/a}   | (d)elete/(c)hange/(y)ank a block surrounded by {      |
"|                    | (e.g. daB, da{ or da} ).                              |
"| <action>at         | (d)elete/(c)hange/(y)ank an HTML tag (e.g. dat).      |
"| <action>it         | (d)elete/(c)hange/(y)ank the contents of an HTML tag  |
"|                    | (e.g. dit).                                           |
"| p                  | Paste stuff after the cursor.                         |
"| P                  | Paste stuff before the cursor.                        |
"| x                  | Delete a character.                                   |
"| r                  | Replace a character.                                  |
"| s                  | Delete a character and put you into insert mode.      |
"| i                  | Puts you in insert mode before the cursor.            |
"| a                  | Puts you in insert mode after the cursor.             |
"| I                  | Puts you in insert mode at the beginning of the       |
"|                    | current line.                                         |
"| A                  | Puts you in insert mode at the end of the current     |
"|                    | line.                                                 |
"| o                  | Inserts a new line below the current one and drops    |
"|                    | you into insert mode.                                 |
"| O                  | Inserts a new line above the current one and also     |
"|                    | drops you into insert mode.                           |
"| gi                 | Puts you into insert mode at the last place you left  |
"|                    | insert mode.                                          |
"| Ctrl-h             | In insert mode lets you delete the last character     |
"|                    | you typed.                                            |
"| Ctrl-w             | In insert mode lets you delete the last word          |
"|                    | you typed.                                            |
"| Ctrl-u             | In insert mode lets you delete the last line          |
"|                    | you typed.                                            |
"| u                  | Undo changes.                                         |
"| Ctrl-r             | Redo changes.                                         |
"| U                  | Undo all changes.                                     |

"------------------------------------------------------------------------------
" Autocompletion
"------------------------------------------------------------------------------
"| Mapping | Operation                                                        |
"|---------|------------------------------------------------------------------|
"| Ctrl-n  | Get a list of word suggestions while in insert mode              |
"|         | and use Ctrl-n and Ctrl-p to go back and forth in the suggestion |
"|         | list.                                                            |

"------------------------------------------------------------------------------
" Visual mode (selecting text)
"------------------------------------------------------------------------------
"| Mapping | Operation                                                        |
"|---------|------------------------------------------------------------------|
"| v       | Character-wise visual mode. When you move around you go          |
"|         | selecting character by character.                                |
"| V       | Line-wise visual mode. When you move around you go selecting     |
"|         | line by line.                                                    |
"| Ctrl-v  | Block-wise visual mode. When you move around you go selecting    |
"|         | rectangular blocks of text.                                      |

"------------------------------------------------------------------------------
" vimdiff
"------------------------------------------------------------------------------
"| Mapping/Commands           | Operation                                     |
"|----------------------------|-----------------------------------------------|
"| :diffsplit <filename>      | Activate diff mode.                           |
"| :vert diffsplit <filename> | Activate diff mode in vertical windows.       |
"| Ctrl-w Ctrl-w              | Switch between diff windows.                  |
"| ]c                         | Jump to the next change.                      |
"| [c                         | Jump to the previous change.                  |
"| :diffupdate                | If you edit file in this mode then use this   |
"|                            | command to update diff.                       |
"| :diffget                   | Apply change from adjacent diff window to     |
"|                            | current diff window.                          |
"| :diffput                   | Apply change from current diff window to      |
"|                            | adjacent diff window                          |

"------------------------------------------------------------------------------
" Windows and Tabs
"------------------------------------------------------------------------------
"| Mapping/Commands | Operation                                               |
"|------------------|---------------------------------------------------------|
"| :sp <path>       | Open a file in a horizontal split.                      |
"| :vs <path>       | Open a file in a vertical split.                        |
"| Ctrl-w s         | Split window horizontally.                              |
"| Ctrl-w v         | Split window vertically.                                |
"| Ctrl-w h         | Takes you to the split on the left (also Ctrl-w Ctrl-h).|
"| Ctrl-w j         | Takes you to the split below (also Ctrl-w Ctrl-j).      |
"| Ctrl-w k         | Takes you to the split above (also Ctrl-w Ctrl-k).      |
"| Ctrl-w l         | Takes you to the split on the right                     |
"|                  | (also Ctrl-w Ctrl-l).                                   |
"| Ctrl-w w         | Lets you switch windows (also Ctrl-w Ctrl-w).           |
"| Ctrl-w o         | Closes all other windows and makes the current window   |
"|                  | the only one on the screen (also Ctrl-w Ctrl-o).        |
"| Ctrl-w >         | Resize a vertical split (increasing it's width).        |
"| Ctrl-w <         | Resize a vertical split (decreasing it's width).        |
"| Ctrl-w |         | The vertical split take it's maximum width.             |
"| Ctrl-w +         | Resize a horizontal split (increasing it's height).     |
"| Ctrl-w -         | Resize a horizontal split (decreasing it's height).     |
"| Ctrl-w _         | The horizontal split take it's maximum height.          |
"| Ctrl-w =         | All splits have equal dimensions.                       |
"| :tabe <path>     | Open a file in a new tab.                               |
"| Ctrl-w t         | Move an existing window into it's own tab.              |
"| gt               | Move to the next tab.                                   |
"| gT               | Move to the previous tab.                               |
"| <count>gt        | Move to the tab number count.                           |
"| :tabonly         | Close all tabs except the active one.                   |

"------------------------------------------------------------------------------
" Managing buffers
"------------------------------------------------------------------------------
"| Commands     | Operation                                                   |
"|--------------|-------------------------------------------------------------|
"| :ls          | List the current buffers (including their numbers).         |
"| :b <number>  | Display the buffer with the given number                    |
"|              | (no space is needed).                                       |
"| :b <partial> | Display the first buffer matching the partial name          |
"|              | (or press Tab for name completion).                         |
"| :bd          | Delete the current buffer; will fail if unsaved             |
"|              | (nothing is deleted).                                       |
"| :bd!         | Delete the current buffer; will discard any changes         |
"|              | (changes are lost).                                         |

"------------------------------------------------------------------------------
" Open, Save and Exit
"------------------------------------------------------------------------------
"| Commands     | Operation                                                   |
"|--------------|-------------------------------------------------------------|
"| :e <path>    | Open a file to edit.                                        |
"| :w           | Save the current file.                                      |
"| :wa          | Save all of the files.                                      |
"| :q           | Quit.                                                       |
"| :q!          | Quit without saving.                                        |
"| :qa          | Quit all of the files.                                      |
"| :qa!         | Quit all of the files without saving.                       |
"| :x           | Save and quit.                                              |
"| :xa          | Save all of the files and quit.                             |

" Force saving files that require root permission.
cnoremap w!! %!sudo tee > /dev/null %

" Type kj or jk to call Esc (and save the file) in insert mode.
inoremap kj <Esc>:w<CR>
inoremap jk <Esc>:w<CR>
" Just escape (the real escape in vim is Ctrl-[) without save.
inoremap j[ <Esc>

" Indent lines.
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <Tab> <C-t>
inoremap <S-Tab> <C-d>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Undo, Redo.
nnoremap <C-z> :undo<CR>
nnoremap <C-y> :redo<CR>
inoremap <C-z> <Esc>:undo<CR>
inoremap <C-y> <Esc>:redo<CR>

" Copy selected text (yank visual) to clipboard.
vnoremap <C-c> "*y

" Move between windows.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-\> <C-w>w

" Use <Space>; for commands.
nnoremap <Leader>; :

" Jump to the begining of the line.
nnoremap <Leader>jb ^
" Jump to the end of the line.
nnoremap <Leader>je $

" Jump between parens.
nnoremap <Leader>jp %
vnoremap <Leader>jp %

" Search into the file (using very magic).
nnoremap <Leader>f /\v
" Search for visually selected text.
vnoremap <Leader>f y/\V<C-r>=escape(@",'/\')<CR><CR>
" Find merge conflict markers.
nnoremap <silent> <Leader>fc <Esc>/\v^[<=>]{7}( .*\|$)<CR>
" Clear the highlighting of :set hlsearch.
nnoremap <Leader>cs :let @/=""<CR>

" Type <Space>w to save file (a lot faster than :w<Enter>).
nnoremap <Leader>w :w<CR>
" Type <Space>q to quit.
nnoremap <Leader>q :q<CR>
" Type <Space>fq to force quit (will discard any changes).
nnoremap <Leader>fq :q!<CR>
" Type <Space>bq to close the actual buffer.
nnoremap <Leader>bq :bd<CR>
" Type <Space>x to save and quit.
nnoremap <Leader>x :x<CR>

" Type <Space>ew and it expands to :e path/to/directory/of/current/file/.
" This makes it really easy to open several files from the same directory.
" The ‘ew’ command stands for open in window.
" The other variants stand for open in split (‘es’),
" open in vertical split (‘ev’) and open in tab (‘et’) respectively.
cnoremap %% <C-r>=fnameescape(expand('%:h')).'/'<CR>
map <Leader>ew :e %%
map <Leader>es :sp %%
map <Leader>ev :vsp %%
map <Leader>et :tabe %%

" Toggle text wrapping.
nnoremap <silent> <Leader>iw :set invwrap wrap?<CR>

" Split vertically/horizontally and focus new window.
nnoremap <Leader>sv <C-w>v<C-w>l
nnoremap <Leader>sh <C-w>s<C-w>j

" Edit/Reload .vimrc configuration file.
nnoremap <Leader>ec :e $MYVIMRC<CR>
nnoremap <Leader>rc :source $MYVIMRC<CR>

" Show Netrw directory explorer (directory tree).
nnoremap <Leader>tr :e .<CR>
" Show open buffers list.
nnoremap <Leader>ls :ls<CR>:b

" Show two files differences in vertical windows.
nnoremap <Leader>df :vert diffsplit<Space>

"############################## Function mappings #############################

"==============================================================================
" TrimWhitespace
"==============================================================================
" Call the trimming function.
nnoremap <Leader>tw :call TrimWhitespace()<CR>

"==============================================================================
" RelativeNumberToggle
"==============================================================================
" Toggle between normal and relative numbering.
nnoremap <Leader>rn :call RelativeNumberToggle()<CR>

"############################### Plugin mappings ##############################

"==============================================================================
" fzf.vim
"==============================================================================
" Find files with fuzzy finder.
nnoremap <C-p> :Files<CR>
nnoremap <Leader>p :Files<CR>
" Search in files with ripgrep.
nnoremap <Leader>F :Rg<CR>

"==============================================================================
" ferret
"==============================================================================
" Note: Using |:noremap| will not work with <Plug> mappings.
" Search with :Ack in files.
nmap <Leader>sa <Plug>(FerretAck)
" Search with :Ack for the word currently under the cursor.
nmap <Leader>sc <Plug>(FerretAckWord)
" :Acks, which allows you to run a multi-file replace across all the files
" placed in the quickfix window by a previous invocation of :Ack.
nmap <Leader>ra <Plug>(FerretAcks)

"==============================================================================
" surround.vim
"==============================================================================
" In the following mappings, <character> can be any of [, ], (, ), ", ', `,
" {, }.
"
"| Mapping                      | Operation                                   |
"|------------------------------|---------------------------------------------|
"| ds<character>                | Delete surrounding <character>              |
"| cs<character><new character> | Replace surrounding <character> with        |
"|                              | <new character>                             |
"| yss<character>               | Surround text with <character>              |
"| ysiw<character>              | Surround word under the cursor with         |
"|                              | <character>                                 |
"| dst                          | Delete surround tag (works on HTML tags)    |
"| cst<character>               | Replace surrounding tag with <character>    |
"| S<character>                 | I visual mode (capital V) surround the      |
"|                              | selected text                               |

"==============================================================================
" commentary.vim
"==============================================================================
" It's mapped to gc (think "go comment") and works on any text-object or
" motion, as you'd expect. Some sample usages are:
"| Mapping | Operation                                                        |
"|---------|------------------------------------------------------------------|
"| gcc     | Comment out the current line.                                    |
"| gc2j    | Comment down two lines.                                          |
"| gcip    | Comment out the current paragraph.                               |

"==============================================================================
" fugitive.vim
"==============================================================================
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>ga :Gcommit --amend -v<CR>
nnoremap <Leader>gv :Gcommit -v<CR>
nnoremap <Leader>gp :Git push<CR>

