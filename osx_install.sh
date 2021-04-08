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
brew install ack # replacement for grep 
brew install corretto@11
brew install corretto
brew install bash-completion
brew install zsh
brew install zsh-syntax-highlighting
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

# install pip and virtualenv
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
pip3 install virtualenv
pip3 install virtualenvwrapper

echo "cleaning up brew"
brew cleanup

# download meslolg nf fonts
echo "downloading meslolg nf fonts..."
curl -o https://github.com/romkatv/powerlevel10k-media/raw/master/meslolgs%20nf%20regular.ttf  ~/library/fonts
curl -o https://github.com/romkatv/powerlevel10k-media/raw/master/meslolgs%20nf%20bold.ttf  ~/library/fonts
curl -o https://github.com/romkatv/powerlevel10k-media/raw/master/meslolgs%20nf%20italic.ttf  ~/library/fonts
curl -o https://github.com/romkatv/powerlevel10k-media/raw/master/meslolgs%20nf%20bold%20italic.ttf  ~/library/fonts

# install zsh & oh my zsh
echo "installing oh my zsh..."
curl -l http://install.ohmyz.sh | sh

# install powerline10k theme
echo "installing powerline10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

echo "setting up zsh plugins..."
mkdir -p ~/.oh-my-zsh/custom/plugins
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
source ./zsh-autosuggestions/zsh-autosuggestions.zsh
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

### requires password input
echo "setting zsh as default shell..."
chsh -s /bin/zsh

# configure your powerline10k 
p10k configure
echo "p10k is configured, 'p10k configure' to reconfigure"
read -p "press [enter] in you want to continue..."

##
## VIM CONFIG
##

echo "Setting up vim colors..."
# Setup vim colors, use sonokai
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/autoload/airline/themes/
mkdir -p ~/.vim/autoload/lightline/colorscheme/
curl https://raw.githubusercontent.com/sainnhe/sonokai/master/colors/sonokai.vim >> ~/.vim/colors/sonokai.vim
curl https://raw.githubusercontent.com/sainnhe/sonokai/master/autoload/airline/themes/sonokai.vim >> ~/.vim/autoload/airline/themes/sonokai.vim
curl https://raw.githubusercontent.com/sainnhe/sonokai/master/autoload/lightline/colorscheme/sonokai.vim >> ~/.vim/autoload/lightline/colorscheme/sonokai.vim

echo "\" important!!\nset termguicolors\n\n\" the configuration options should be placed before 
'colorscheme sonokai'\n\nlet g:sonokai_style = 'andromeda'\nlet g:sonokai_enable_italic = 1\nlet g:sonokai_disable_italic_comment = 1\n\ncolorscheme sonokai" >>! ~/.vimrc
echo "Done with vim colors config!"

# adds start script for zsh-syntax-highlighting
echo "# start zsh-syntax-highlighting\nsource /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>! ~/.zshrc

echo "Installing homebrew casks"
brew install --cask \
  appcleaner \
  beyond-compare \
  aerial \
  # cheatsheet \
  docker \
  dropbox \
  1password \
  istat-menus \
  iterm2 \
  nordvpn \
  spectacle \
  sourcetree \
  spotify \
  visual-studio-code \
  vlc

function linkfile() {
  local name=$1

  local from="$HOME/$name"
  local to="$PWD/$name"

  if [ ! -e $from -o $force_flag -ne 0 ]; then
    ln -fns $to $from

    echo "Link \"$from\""
  else
    echo "Skip \"$from\": File exists"
  fi
}
# link current .zshrc file to the one under $HOME
linkfile ".zshrc"

# cleanup
echo "Cleaning up the last stuff..."
brew cleanup
rm -f -r /Library/Caches/Homebrew/*
