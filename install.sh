sudo apt update && upgrade

# gcc
sudo apt install build-essential
sudo apt install software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt install gcc-12 g++-12 gcc-13 g++-13 -y
sudo apt install libmpfr-dev libgmp3-dev libmpc-dev -y

sudo apt install python3 python3-pip ipython3

# exa
cargo install exa

# zoxide
# curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
cargo install zoxide --locked

# fzf
sudo apk install fzf

# ripgrep
cargo install ripgrep

# fd
cargo install fd-find

# n
curl -L https://bit.ly/n-install | bash
n latest

# stow
sudo apt install stow

# oh-my-zsh plugin
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


sudo apt-get install keychain

dircolors -p > .dircolors

# neovim

# tmux
sudo apt install libevent-dev ncurses-dev build-essential bison pkg-config
sudo apt install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sudo apt-get install ninja-build gettext cmake unzip curl build-essential
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb
