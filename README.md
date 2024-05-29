# gabref dotfiles

stow */

<img src="/.assets/main.jpg" alt="main" width="600px" />
<img src="/.assets/lsp.jpg" alt="main" width="600px" />
<img src="/.assets/telescope.jpg" alt="main" width="600px" />

## Install script

Not finished

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/gabref/dotfiles/main/install.sh)"
```

test in container
```bash
docker pull ubuntu:jammy
docker run -it --rm=true ubuntu:jammy /bin/bash
passwd root
adduser gabre
apt install sudo
usermod -aG gabre sudo
```

## Requirements

Set zsh as your login shell:
`chsh -s $(which zsh)`

oh-my-zsh
suggestions

## Fast vi mode in zsh shell
[zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode)

## To install

### Telescope Dependencies
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [fd](https://github.com/sharkdp/fd)

### Tmux 
* [Tmux Package Manager](github.com/tmux-plugins/tpm)

go install github.com/arl/gitmux@latest

## Nice links
* (Alacritty config)[https://github.com/mauromotion/dotfiles/blob/main/alacritty/alacritty.toml]
