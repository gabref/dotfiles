# zsh config dir
export ZDOTDIR=$HOME/.config/zsh

# if running zsh
if [ -n "$ZSH_VERSION" ]; then
	# include .zshrc if it exists
	# if [ -f "$ZDOTDIR/.zshrc" ]; then
	# 	. "$ZDOTDIR/.zshrc"  
	# fi
fi
