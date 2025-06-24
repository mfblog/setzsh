#!/bin/bash

set -e

echo "开始更新系统并安装必要软件..."
apt update && apt upgrade -y
apt install -y zsh zoxide curl git vim

echo "重新安装 zsh-common 以确保补全文件完整..."
apt install --reinstall -y zsh-common

echo "安装 starship 提示符..."
curl -sS https://starship.rs/install.sh | sh -s -- --yes

echo "创建 starship 配置目录，并生成配置文件..."
mkdir -p ~/.config
starship preset catppuccin-powerline -o ~/.config/starship.toml

echo "设置默认 shell 为 zsh..."
chsh -s "$(which zsh)"

echo "克隆并安装 fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

echo "写入 .zshrc 配置..."
cat >> ~/.zshrc <<'EOF'

# 启用 starship 提示符
eval "$(starship init zsh)"

# 启用 zoxide 快速跳转
eval "$(zoxide init zsh)"

# 启用 fzf 自动补全与快捷键
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 添加 fzf 路径
export PATH="$HOME/.fzf/bin:$PATH"

# 添加 Debian 补全路径
fpath=(/usr/share/zsh/functions/Completion/Debian $fpath)

# 启用补全功能
autoload -Uz compinit
compinit

# 常用别名
alias ll='ls -l'
alias la='ls -la'
alias l='ls -CF'

alias ss='systemctl start'
alias st='systemctl status'
alias rs='systemctl restart'

alias jou='journalctl -u'

EOF

echo "安装和配置完成！请重新登录或执行 'exec zsh' 以使用 zsh 和新配置。"
