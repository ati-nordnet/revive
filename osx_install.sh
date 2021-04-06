# #!/bin/sh
myname="Atila Aliosmanov"
email="atispor@gmail.com"
echo "Creating an SSH key for you..."
ssh-keygen -t rsa -b 4096 -C $email
# Start the ssh-agent in the background.
eval "$(ssh-agent -s)"

touch ~/.ssh/config

echo "Host *\n  AddKeysToAgent yes\n  UseKeychain yes\n  IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config

# Add your SSH private key to the ssh-agent and store your passphrase in the keychain
ssh-add -K ~/.ssh/id_rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
pbcopy < ~/.ssh/id_rsa.pub
echo "ssh key COPIED TO CLIPBOARD!"
read -p "Press [Enter] key after this..."

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

# install pip and virtualenv
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
pip install virtualenv
pip install virtualenvwrapper

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
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

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

echo "\" important!!\nset termguicolors\n\n\" the configuration options should be placed before `colorscheme sonokai`\n\nlet g:sonokai_style = 'andromeda'\nlet g:sonokai_enable_italic = 1\nlet g:sonokai_disable_italic_comment = 1\n\ncolorscheme sonokai" >>! ~/.vimrc
echo "Done with vim colors config!"

# adds start script for zsh-syntax-highlighting
echo "# start zsh-syntax-highlighting\nsource /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >>! ~/.zshrc

echo "Installing homebrew casks"
brew install --cask \
  appcleaner \
  beyond-compare \
  aerial \
  clippy \
  cheatsheet \
  diffmerge \
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

# cleanup
echo "Cleaning up the last stuff..."
brew cleanup
rm -f -r /Library/Caches/Homebrew/*
