" ~/.config/nvim/vim_legacy.vim
if exists('g:vscode')
    " VSCode-Neovim is running – put VSCode-specific Vimscript config here [oai_citation:0‡github.com](https://github.com/vscode-neovim/vscode-neovim#:~:text=if%20exists%28%27g%3Avscode%27%29%20,ordinary%20Neovim%20endif)
    " (No plugin installation commands here; use Lazy.nvim for that)
    " Example: define surround mappings (if not set by plugin defaults)
    xmap S  <Plug>VSurround      " surround selection (vim-surround)
    xmap gS <Plug>VgSurround     " surround selection with new lines (vim-surround)
endif
