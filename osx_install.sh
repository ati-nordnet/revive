# #!/bin/sh

## homebrew
# 
# check for homebrew, install if we don't have it
if test ! $(which brew); then
  echo "installing homebrew..."
  /bin/bash -c "$(curl -fssl https://raw.githubusercontent.com/homebrew/install/master/install.sh)"
fi 

# update homebrew recipes
echo "updating homebrew..."
brew update

# installing other brew packages
echo "installing packages..."
brew tap homebrew/cask-versions
brew install ack # replacement for grep 
brew install corretto
brew install corretto
brew install corretto8
brew install corretto11
brew install bash-completion
brew install zsh
brew install git
brew install tree
brew install fzf
# to install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
brew install vim
brew install wget
brew install python
brew install the_silver_searcher
brew install kubectl
brew install kubectx
brew install kustomize
brew install tfenv
# install corretto 15
# curl -LO https://corretto.aws/downloads/latest/amazon-corretto-15-x64-linux-jdk.tar.gz

# install pip and virtualenv
# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# pip3 install virtualenv
# pip3 install virtualenvwrapper

echo "cleaning up brew"
brew cleanup

# download meslolg nf fonts
echo "downloading meslolg nf fonts..."
curl -o https://github.com/romkatv/powerlevel10k-media/raw/master/meslolgs%20nf%20regular.ttf  ~/library/fonts
curl -o https://github.com/romkatv/powerlevel10k-media/raw/master/meslolgs%20nf%20bold.ttf  ~/library/fonts
curl -o https://github.com/romkatv/powerlevel10k-media/raw/master/meslolgs%20nf%20italic.ttf  ~/library/fonts
curl -o https://github.com/romkatv/powerlevel10k-media/raw/master/meslolgs%20nf%20bold%20italic.ttf  ~/library/fonts

# install powerline10k theme
echo "installing powerline10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# install zsh & oh my zsh
echo "installing oh my zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "setting up zsh plugins..."
mkdir -p ~/.oh-my-zsh/custom/plugins
cd ~/.oh-my-zsh/custom/plugins

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

### requires password input
echo "setting zsh as default shell..."
chsh -s /bin/zsh

echo "Setting up vim colors..."
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/autoload/airline/themes/
mkdir -p ~/.vim/autoload/lightline/colorscheme/
curl https://raw.githubusercontent.com/sainnhe/sonokai/master/colors/sonokai.vim >>! ~/.vim/colors/sonokai.vim
curl https://raw.githubusercontent.com/sainnhe/sonokai/master/autoload/airline/themes/sonokai.vim >>! ~/.vim/autoload/airline/themes/sonokai.vim
curl https://raw.githubusercontent.com/sainnhe/sonokai/master/autoload/lightline/colorscheme/sonokai.vim >>! ~/.vim/autoload/lightline/colorscheme/sonokai.vim

echo "Installing homebrew casks"
brew install --cask \
  appcleaner \
  beyond-compare \
  aerial \
  google-cloud-sdk \
  istat-menus \
  iterm2 \
  spectacle \
  sourcetree \
  spotify \
  visual-studio-code \
  vlc

echo "Copy and link the existing .zshrc file with the one under $HOME folder "
cp -f ./.zshrc ~/.zshrc
ln -fns ~/.zshrc ./.zshrc

# cleanup
echo "Cleaning up the last stuff..."
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

echo "Finished installation!"