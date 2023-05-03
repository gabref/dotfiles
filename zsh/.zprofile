# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# zsh config dir
export ZDOTDIR=$HOME/.config/zsh

# if running zsh
if [ -n "$ZSH_VERSION" ]; then
	# include .zshrc if it exists
	if [ -f "$ZDOTDIR/.zshrc" ]; then
		. "$ZDOTDIR/.zshrc"  
	fi
fi
