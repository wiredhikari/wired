# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/hikari/.zshrc'

autoload -U compinit promptinit
compinit


alias cr="cargo run"
alias ct="cargo test"
alias cn="cargo new"
alias cb="cargo build"
#alias l="ls -alh --color=tty"
#alias ls="ls --color=tty"
alias l="lsd"
alias ls="lsd"
alias c="clear"
alias n="nvim"
alias cpy="xclip -sel clip"
alias cat="bat"
alias t="tuxfetch"
alias sea="sudo emerge --ask"
alias eas="emerge --ask -S"
alias s="sudo"
alias sf="screenfetch"
alias reb="sudo reboot -n"
alias neo="neofetch"
alias x="bash xrandr_conf"
alias k="kdocker"
alias f="flameshot screen -p dump/ -c"
alias ff="flameshot full -p /mnt/storage/Gallery/Dump -c"
alias f1="flameshot screen -p /mnt/storage/Gallery/Dump -c -d 500"
alias f2="flameshot screen -p /mnt/storage/Gallery/Dump -c -d 1000"
alias ff1="flameshot full -p /mnt/storage/Gallery/Dump -c -d 500"
alias ff2="flameshot full -p /mnt/storage/Gallery/Dump -c -d 1000"
alias v="viewnior"
alias update="sudo emerge --ask --verbose --changed-use --update --deep world"
alias kf="killall flameshot"
alias kp="killall picom"
alias fm="thunar"
alias seas="sudo emerge --sync"
alias m="mangadesk"
alias py="python3"
alias ne="neofetch --source --w3m .config/neofetch/images/gentoo_dark.png --loop"
alias rm -rf /="echo "Love your  "" 
alias tig="git"
alias gir="git"
alias gti="git"
alias tgi="git"
alias gc="git clone"

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
promptinit; prompt gentoo
zstyle ':completion::complete:*' use-cache 1
setopt correctall



# End of lines added by compinstall
source "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme"
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
PATH=/home/hikari/.cargo/bin/:/home/hikari/.local/bin/:$PATH
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

export GPG_TTY=$(tty)
export EDITOR='nvim'
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)


export LC_ALL=C.UTF-8
