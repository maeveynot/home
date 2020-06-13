source ~/.vimrc

" To setup plugins:
"   - curl -L -o ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   - :PlugInstall
"   - :UpdateRemotePlugins

call plug#begin()
Plug 'ncm2/ncm2'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'jamessan/vim-gnupg'
"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
call plug#end()
