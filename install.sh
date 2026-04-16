echo "Installing some basic terminal tools…"
brew install fd
#apt install starship apt-get install fd-find
echo "Installing NeoVim…"
brew install neovim
echo "Installing vim plugin manager (vim-plug) and color scheme…"
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Installing Starship terminal prompt…"
brew install starship
echo "Installing Hack typeface"
brew tap homebrew/cask
brew tap homebrew/cask-fonts
brew cask install font-hack
echo "Installing Kitty terminal emulator"
brew install kitty
echo "Installing fzf and rg and fd"
brew install fzf
brew install rg
# apt install ripgrep
echo "Please put 'source .config/zsh/.zshrc' into your .zshrc"
echo "Please start vim and do :PlugInstall so vim-plug does its thing"
