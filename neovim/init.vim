function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons' 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'rust-lang/rust.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sbdchd/neoformat'
Plug 'KarimElghamry/vim-auto-comment'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" Plug 'github/copilot.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'numToStr/Comment.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'puremourning/vimspector'
Plug 'ziglang/zig.vim'

call plug#end()

let &colorcolumn=join(range(80,999),",")
let g:indentLine_color_term = 255
let g:tablineclosebutton=1
let g:indentLine_setColors = 0
hi Comment ctermfg=Grey
highlight ColorColumn ctermbg=234 guibg=#FFFFFF

set encoding=UTF-8
set number relativenumber
set incsearch hlsearch cursorline ignorecase cindent
set tabstop=4 shiftwidth=4 expandtab
set undofile undodir=~/.vim/undodir 
set clipboard=unnamed
set autoread

syntax on

inoremap jk <Esc>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>

let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
let g:LanguageClient_serverCommands = {'rust': ['rust-analyzer'],}
let NERDTreeShowHidden=0
let g:rustfmt_autosave = 1
let g:neoformat_try_node_exe = 1
autocmd BufWritePre *.js Neoformat

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
      enable = true,
  },
  incremental_selection = {
      enable = false,
  },
  ensure_installed = {'javascript'}
}
EOF







" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
