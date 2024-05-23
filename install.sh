sudo apt update -y && upgrade -y

# git
sudo apt install git -y

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# gcc
sudo apt install build-essential -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt install gcc-12 g++-12 gcc-13 g++-13 -y
sudo apt install libmpfr-dev libgmp3-dev libmpc-dev -y

sudo apt install python3 python3-pip ipython3 -y

# install rust
sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
. "$HOME/.cargo/env"

# exa
cargo install exa

# zoxide
# curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
cargo install zoxide --locked

# fzf
sudo apk install fzf -y

# ripgrep
cargo install ripgrep

# fd
cargo install fd-find

# n
curl -L https://bit.ly/n-install | bash
n latest

# stow
sudo apt install stow -y

# oh-my-zsh plugin
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


sudo apt-get install keychain -y

dircolors -p > .dircolors

# tmux
sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config -y
sudo apt install tmux -y
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# neovim
sudo apt-get install ninja-build gettext cmake unzip curl build-essential -y
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

# my configs
cd $HOME
git clone https://github.com/gabref/dotfiles.git
cd dotfiles
stow */
