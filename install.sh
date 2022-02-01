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
echo "Please put 'source .config/zsh/.zshrc' into your .zshrc"
echo "Please start vim and do :PluginInstall so vim-plug does its thing"
