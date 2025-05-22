# bd jumps backward in paths https://github.com/vigneshwaranr/bd
alias bd='. bd -si'

# run bat instead of cat
alias cat="bat"

# gsw - run gnome-screenshot capture window
alias gsw='gnome-screenshot -w'

# gsa - run gnome-screenshot capture area
alias gsa='gnome-screenshot -a'

alias python=python3
# alias pip=pip3

# mw-sensors - show temperatures
alias mw-sensors='sensors'

# mw-nmcli-examples - show nmcli examples
alias mw-nmcli-examples='man nmcli-examples'

# mw-interface - show only interfaces
alias mw-interface='ip addr show | grep ": \w*"'

# mw-interface-vlan - show only interfaces with vlan tags
alias mw-interface-vlan='ip addr show | grep ": \w*\.[0-9]*@\w*"'

# mw-extip - show the public IP address your are using
# alias mw-extip='dig +short myip.opendns.com @resolver1.opendns.com;dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed "s/"//g"'
alias mw-extip='dig +short myip.opendns.com @resolver1.opendns.com; dig -6 TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed "s/\"//g"'


# mw-ipen0 - show IP info for wlan0
alias mw-ipen0='ip addr show wlp61s0 | grep "link\|inet";ip route | grep default | grep wlp0s20f3;nmcli dev show wlp61s0 | grep DNS | grep IP4'

# mw-ipen6 - show IP info for enp60s0
alias mw-ipen6='ip addr show enp60s0 | grep "link\|inet";ip route | grep default | grep enp60s0;nmcli dev show enp60s0 && grep DNS'

# mw-ipen8 - show IP info for enp8s0
alias mw-ipen8='ip addr show enp8s0 | grep "link\|inet";ip route | grep default | grep enp60s0;nmcli dev show enp60s0 | grep DNS | grep IP4;ip addr show enp60s0 | grep inet6'

# mw-nmshrun - show status of network manager
alias mw-nmshrun="nmcli -t -f RUNNING general"

# mw-nmshstate - show network manager state
alias mw-nmshstate="nmcli -t -f STATE general"

# mw-nmcli-vlan-dhcp - add a vlan interface $1 is the vlan id
alias mw-nmcli-vlan-dhcp='(){nmcli con add type vlan con-name vl$1 dev enp60s0 id $1 autoconnect yes}'

# mw-nmcli-vlan-mac - change the MAC on the vlan interface $1 vlan id, $2 MAC with colons
alias mw-nmcli-vlan-mac='(){sudo ifconfig enp60s0.$1 hw ether $2}'

# mw-nmshprofiles - show network connection profiles $1 is interface name
alias mw-nmshprofiles='(){nmcli -a -f CONNECTIONS device show $1}'

# mw-nmconnectprof - connect to an existing network profile $1 - connection name, $2 ifname
alias mw-nmconnectprof='(){nmcli -p connection up "$1" ifname $2}'

# mw-nmshipv4 - show profile IPv4 settings. Profile must be active. $1 is profile name I.E. "Wired connection 1"
alias mw-nmshipv4='(){nmcli -a -f IP4 connection show $1}'

# mw-nmwifi - show wifi properties
alias mw-nmwifi='nmcli -f GENERAL,WIFI-PROPERTIES dev show $1'

# mw-nmsh-ap - lists available Wi-Fi access points known to NetworkManager
alias mw-nmsh-ap='nmcli dev wifi'

# show wifi passwords
alias mw-nmshwifi='(){sudo nmcli -a -p device wifi show-password ifname $1}'

# show wifi password of saved SSIDs
alias mw-nmshwifi-pw='(){sudo nmcli connection show $1 -s | grep psk:}'

# mw-nmlldp list lldp neighbors
alias mw-nmlldp='(){sudo nmcli -a -p device lldp list ifname $1}'

# mw-running_services - show running systemd services
alias mw-running_services='systemctl list-units --type=service --state=running'

# mw-manuf - show vendor to MAC address mapping
# alias mw-manuf='() {cd ~/Insync/michael.hubbard999@gmail.com/GoogleDrive/Python/Scripts/prod && python3 manuf.py $1 && cd -}'
alias mw-manuf='() {j prod && python3 manuf.py $1 && cd -}'

#Run the nmap ntp-info script. $1 is the ip of the ntp server.
alias mw-ntp='(){sudo nmap -sU -p 123 --script ntp-info $1}'

# open ~/.oh-my-zsh/custom/my-aliases.zsh
alias ec1='$EDITOR ~/.oh-my-zsh/custom/my-aliases.zsh'

# rerun ~/.zshrc after making changes
alias sc='exec zsh'

# mw-dang - add sudo and repeat the last command
alias mw-dang='sudo $(fc -ln -1)'

alias wtf='(){man $1}'

# mw-ports show netstat ports
alias mw-ports='netstat -tulanp'

# mw-vmware - Recompile VMware kernel
alias mw-vmware='cd /media/mhubbard/Data1/VMs && ./VMware-Update-after-Kernel-upgrade.sh'

# mw-vmnet - Change permission on VMware vnet after upgrading the kernel $1 for vmnet number
alias mw-vmnet='(){sudo chmod a+rw /dev/vmnet$1}'

# mw-vmnet-all - Change permission on VMware vnet after upgrading the kernel
alias mw-vmnet-all='sudo chmod a+rw /dev/vmnet*'

# edit the tftp configuration file 
alias mw-tftp-conf='sudo nano /etc/default/tftpd-hpa'

# start tftpd-hfa and display the status
alias mw-tftp='systemctl start tftpd-hpa && sudo ufw allow from any to any proto udp port 69 && systemctl status tftpd-hpa && sudo sudo ufw status verbose'

#stop tftpd-hfa
alias mw-tftp-stop='systemctl stop tftpd-hpa && sudo ufw delete allow from any to any proto udp port 69 && sudo sudo ufw status verbose'

# add tftp to the firewall
alias mw-tftp-fw='ufw allow from any to any proto udp port 69'


# start the ssh daemon and display the status
alias mw-ssh='sudo systemctl start ssh && sudo ufw allow 22/tcp comment "Open port ssh tcp port 22" && sudo systemctl status ssh && sudo ufw status numbered'

# stop the ssh daemon and display the status
alias mw-ssh-stop='sudo systemctl stop ssh && sudo ufw delete allow 22/tcp && sudo systemctl status ssh && sudo ufw status numbered'

# Start/stop/status of systemd services
alias mw-start='(){sudo systemctl start $1}'
alias mw-restart='(){sudo systemctl restart $1}'
alias mw-reload='(){sudo systemctl reload $1}'
alias mw-stop='(){sudo systemctl stop $1}'
alias mw-status='(){sudo systemctl status $1}'

# mount the WD 3TB Drive
alias mw-mount='sudo mount -t ntfs-3g /dev/sdb1 /mnt/WD-3TB'

# Unmount the WD 3TB Drive
alias mw-umount='sudo umount /dev/sdb1'

# mw-chrome - start chrome and allow local file read
alias mw-chrome='cd /opt/google/chrome;./chrome --allow-file-access-from-files'

# -p no error if existing, make parent directories as needed -v print a message for each created directory
alias mkdir='mkdir -pv'

# hide snap file system
alias df="df -h --exclude=squashfs"

# -c like verbose but report only when a change is made
alias chmod="chmod -c"

alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias back='cd $OLDPWD'

# -i prompt before overwrite -v verbse
alias cp='cp -iv'
alias mv='mv -iv'

alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -'

alias l.='ls -lhFa --time-style=long-iso --color=auto'

# Use Brew-installed tools as defaults
alias ls='eza --icons'       # Modern ls with icons
alias la='eza -la --icons'   # ls -la alternative
alias ll='eza -l --icons'    # ls -l alternative
alias find='fd'              # Faster find
alias grep='rg'              # Faster grep (ripgrep)
alias du='dust'              # Better du
alias top='btm'              # Better top
alias df='duf'	  			 # Better DF
alias ps='procs'             # ps (process viewer with colors)

# EZA aliases 
alias mw-eza1='eza -lT --group-directories-first'

# exa2 display directories first, sort by extension
alias mw-eza2='eza -lF -s extension --group-directories-first'

# alias mw-bright60='xrandr --output eDP-1 --brightness 0.60'

# mw-bright - set a different screen brightness use bright .9
alias mw-bright='xrandr --output eDP-1 --brightness $1'

# mw-kbd set keyboard brightness
alias mw-kbd='sudo brightnessctl --device='dell::kbd_backlight' set $1'

# alias mw-led='sudo brightnessctl --device='intel_backlight' set $1'

# mw-mem5 - get 5 top process eating memory
alias mw-mem5='ps auxf | sort -nr -k 4 | head -5'

# mw-mem10 - get 10 top process eating memory
alias mw-mem10='ps auxf | sort -nr -k 4 | head -10'

# mw-cpu5 - get top process eating cpu 
alias mw-cpu5='ps auxf | sort -nr -k 3 | head -5'

# mw-cpu10 - get top process eating cpu
alias mw-cpu10='ps auxf | sort -nr -k 3 | head -10'

# Bauh - Appimage, snap, flatpak manager
alias mw-bauh='() {cd ~/Insync/michael.hubbard999@gmail.com/GoogleDrive/04_Tools/Bauh && source venv/bin/activate && bauh}'

# lookup MAC vender from OUI. The final command cd - returns to the directory that the command started in.
alias mw-manuf='() {cd ~/Insync/michael.hubbard999@gmail.com/GoogleDrive/Python/Scripts/prod && python3 manuf.py $1 && cd -}'

# Tailspin using cx-config.toml
alias tspincx='tspin --print --config-path ~/.config/tailspin/cx-config.toml $1'

# Tailspin using ios-config.toml
alias tspinios='tspin --print --config-path ~/.config/tailspin/IOS-config.toml $1'

# Log into the Juniper vmx router
alias juniper='ssh -i ~/.ssh/juniper_ed25519_key root@192.168.10.162 H3lpd3sk | ct'

# start termianl RPN calculator
alias rpn='flatpak run fr.rubet.rpn'

# Open the expanso base.yml file
alias espanso-base="espanso path | grep Config | awk '{ print \$2\"/match/base.yml\" }' | xargs micro"

# EZA
alias eza='eza --long --sort=name --group-directories-first'
alias ezat='eza --tree --long --sort=name'

# Pull the password from netperf.bufferbloat.net, parse it and pass to betterspeedtest
alias          bst="curl https://netperf.bufferbloat.net/ | grep \"Today's passphrase\" | awk '{ print \$4 }' | cut -c 7-20 | xargs -0 -I % betterspeedtest.sh -Z \"%\""

# Check which compositor is running
alias way="echo $XDG_SESSION_TYPE"

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Create a new directory and enter it
mkd() {
    mkdir -p "$@"
    cd "$@" || exit
}

# Prevent duplicates in history
setopt hist_ignore_all_dups hist_save_nodups

# "path" shows current path, one element per line.
# If an argument is supplied, grep for it.
path() {
    test -n "$1" && {
        echo $PATH | perl -p -e "s/:/\n/g;" | grep -i "$1"
    } || {
        echo $PATH | perl -p -e "s/:/\n/g;"
    }
}
