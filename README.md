# setzsh
安装步骤
apt update && apt upgrade -y

apt install zsh zoxide -y

## 安装 starship
curl -sS https://starship.rs/install.sh | sh

## 安装主题
mkdir -p ~/.config
starship preset catppuccin-powerline -o ~/.config/starship.toml

chsh -s $(which zsh)

## 安装fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install

vim ~/.zshrc

# 启用 starship 提示符
eval "$(starship init zsh)"

# 启用 zoxide 快速跳转
eval "$(zoxide init zsh)"

# 启用 fzf 自动补全与快捷键（确保你执行过 ~/.fzf/install）
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 添加fzf路径
export PATH="$HOME/.fzf/bin:$PATH"

# 常用别名
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

alias ss='systemctl start'
alias st='systemctl status'
alias rs='systemctl restart'

alias jou='journalctl -u'
