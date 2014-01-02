
# Next 2 from https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

alias openports='sudo lsof -iTCP -sTCP:LISTEN -P'

active_network_interface() {
  route get 0.0.0.0 2>/dev/null | awk '/interface: / {print $2}'
}

local_ip() {
  ipconfig getifaddr $(active_network_interface)
}

pingsweep() {
  which nmap &> /dev/null || { echo "nmap must be installed and on your PATH" >&2; return 1; }
  nmap -sP "$(local_ip | ruby -ne 'puts $_.sub /\d+$/, "0"')-255"
}
