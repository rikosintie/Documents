#call Gnome Text Editor
alias gte="gnome-text-editor"

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

mw-wifi() {
    local wintf dev

    # detect the wifi interface via sysfs
    for dev in /sys/class/net/*(N); do
        [[ -d "$dev/wireless" ]] && { wintf=${dev:t}; break; }
    done

    ip route | grep default
    nmcli dev show $wintf | grep "IP4"
    nmcli dev show $wintf | grep "IP6"
}

mw-eth() {
    local dev ethintf connected=0

    for dev in /sys/class/net/*(N); do
        if [[ -e "$dev/device" && ! -d "$dev/wireless" ]]; then
            ethintf=${dev:t}
            
            # Skip if interface is down
            if ip link show "$ethintf" | grep -qE "state UP|LOWER_UP"; then
                connected=1
                echo "=== Interface: $ethintf ==="
                ip addr show $ethintf | grep "link\|inet"
                ip route | grep $ethintf
                nmcli dev show $ethintf | grep -E "IP4|IP6"
                echo ""
            fi
        fi
    done

    if (( connected == 0 )); then
        echo "No active Ethernet interfaces connected."
    fi
}
# mw-ipwlan0 - show IP info for wlan0
alias mw-ipwlan0='ip addr show wlp3s0 | grep "link\|inet";ip route | grep default | grep wlp0s20f3;nmcli dev show wlp3s0 | grep DNS | grep IP4'

# mw-ipen6 - show IP info for enp60s0
alias mw-ipen6='ip addr show enp60s0 | grep "link\|inet";ip route | grep default | grep enp60s0;nmcli dev show enp60s0 && grep DNS'

# mw-ipen8 - show IP info for enp8s0
alias mw-ipen8='ip addr show enx0050b61ca0c0 | grep "link\|inet";ip route | grep default | grep enx0050b61ca0c0;nmcli dev show enx0050b61ca0c0 | grep DNS | grep IP4;ip addr show enx0050b61ca0c0 | grep inet6'

# Show ip info for br0
alias mw-ipenbr0='ip addr show br0 | grep "link\|inet";ip route | grep default | grep br0;nmcli dev show br0;resolvectl status br0 | grep "DNS Servers:"'

# mw-nmshrun - show status of network manager
alias mw-nmshrun="nmcli -t -f RUNNING general"

# mw-nmshstate - show network manager state
alias mw-nmshstate="nmcli -t -f STATE general"

# mw-nmcli-vlan-dhcp - add a vlan interface $1 is the vlan id
mw-nmcli-vlan-dhcp() {
  nmcli con add type vlan con-name vl$1 dev enp60s0 id $1 autoconnect yes
}
# mw-nmcli-vlan-mac - change the MAC on the vlan interface $1 vlan id, $2 MAC with colons
mw-nmcli-vlan-mac() {
  sudo ifconfig enp60s0.$1 hw ether $2
}
# mw-nmshprofiles - show network connection profiles $1 is interface name
alias mw-nmshprofiles='(){nmcli -a -f CONNECTIONS device show $1}'

# mw-nmconnectprof - connect to an existing network profile $1 - connection name, $2 ifname
alias mw-nmconnectprof='(){nmcli -p connection up "$1" ifname $2}'

# mw-nmshipv4 - show profile IPv4 settings. Profile must be active. $1 is profile name I.E. "Wired connection 1"
alias mw-nmshipv4='(){nmcli -a -f IP4 connection show $1}'
alias mw-nmshipv6='(){nmcli -a -f IP6 connection show $1}'

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

# lookup MAC vendor from OUI. The final command cd - returns to the directory that the command started in.
alias mw-manuf='() {cd /home/mhubbard/Insync/GD/Python/Scripts/prod && python3 manuf.py $1 && cd -}'
alias mw-manuf1='() {z prod && python3 manuf.py $1 && cd -}'

#Run the nmap ntp-info script. $1 is the ip of the ntp server.
alias mw-ntp='(){sudo nmap -sU -p 123 --script ntp-info $1}'

# start chrome and allow local file read
alias mw-chrome='cd /opt/google/chrome;./chrome --allow-file-access-from-files'

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
alias mw-tftp-fw='sudo ufw allow from any to any proto udp port 69'


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

# Display SSH ciphers
alias mw-ssh='ssh -V && echo "" && echo HostKeyAlgorithms && ssh -Q HostKeyAlgorithms && echo "" && echo MACs && ssh -Q MACs && echo "" && echo KEXAlgorithms && ssh -Q KexAlgorithms'

# -p no error if existing, make parent directories as needed -v print a message for each created directory
alias mkdir='mkdir -pv'

# Hide the snap file system
alias df="df -h --exclude=squashfs"

# -c like verbose but report only when a change is made
alias chmod="chmod -c"

alias back='cd $OLDPWD'

# -i prompt before overwrite -v verbse
alias cp='cp -iv'
alias mv='mv -iv'

# list all files with long time format
alias l.='ls -lha --time-style=long-iso --color=auto'

# Use Brew-installed tools as defaults
alias la='eza -la --time-style=long-iso --color=auto --icons'   # ls -la alternative
alias ll='eza -l --time-style=long-iso --color=auto --icons --icons'    # ls -l alternative
alias ls='eza --time-style=long-iso --color=auto --icons'       # Modern ls with icons
alias lt='eza --long --header --git --time-style=long-iso --color=auto' # ls with git status

# alias find='fd'              # Faster find
# alias grep='rg'              # Faster grep (ripgrep)
alias du='dust -rR'              # Better du
alias top='btm'              # Better top
alias df='duf'               # Better DF
alias ps='procs'             # ps (process viewer with colors)

# Hide loop devices
alias lsblk='lsblk -e7'

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

# Use Gear Lever from the cli
alias gearlever='flatpak run it.mijorus.gearlever'

# EZA
alias eza='eza --long --sort=name --group-directories-first'
alias ezat='eza --tree --long --sort=name'

# Pull the password from netperf.bufferbloat.net, parse it and pass to betterspeedtest
alias bst="curl https://netperf.bufferbloat.net/ | grep \"Today's passphrase\" | awk '{ print \$4 }' | cut -c 7-20 | xargs -0 -I % betterspeedtest.sh -Z \"%\""

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
# Fix sniffnet after an upgrade
fix-sniffnet() {
  sudo setcap cap_net_raw,cap_net_admin=eip "$(readlink -f "$(which sniffnet)")"
  echo "✅ Sniffnet capabilities fixed!"
}
find_man() {
    man $1 | grep -- $2
}

# alias iwget='echo "AP Mac " && iwgetid -ar && echo "Interface Frequency " && iwgetid -f && echo "SSID " && iwgetid -s'

mw-iwget () {
	APMac=`iwgetid -ar`
	IntFace=`iwgetid -f`
	ID=`iwgetid -s`
	echo "AP Mac:" $APMac && echo "Interface:" $IntFace && echo "SSID:" $ID
}

sparrow () {
	cd ~/Insync/GD/04_Tools/sparrow-wifi
	source venv/bin/activate
	sudo /home/mhubbard/Insync/GD/04_Tools/sparrow-wifi/venv/bin/pip3 install --upgrade manuf
	sudo /home/mhubbard/Insync/GD/04_Tools/sparrow-wifi/venv/bin/python3 sparrow-wifi.py
}

# Change dir function example up 2

up() {
  local d=""
  for ((i=0; i<$1; i++)); do
    d+="../"
  done
  cd "$d" || return
}


# red section header + separator helpers (top-level so they're
# defined once and don't leak/redefine on every call)
_mw_hdr() { printf "\e[31m         %s\e[0m\n\n" "$1"; }
_mw_sep() { printf "\n---------------------\n\n"; }

# return the IPv4 address (with CIDR) of an interface, or "no IP"
_mw_ip() {
    local addrs
    addrs=$(ip -br addr show dev "$1" 2>/dev/null \
            | awk '{$1=$2=""; print}' \
            | tr ' ' '\n' | grep -v '^fe80' | grep . | paste -sd' ')
    print -r -- "${addrs:-no IP}"
}

# verify that netplan is working with
# NetWorkManager for wifi
# networkd for ethternet
mw-nplan() {
    local ethif="br0"          # bridge/ethernet interface (edit as needed)
    local wintf dev

    # detect the wifi interface via sysfs (robust; no perl/proc parsing)
    for dev in /sys/class/net/*(N); do
        [[ -d "$dev/wireless" ]] && { wintf=${dev:t}; break; }
    done

    _mw_hdr "Check that route metrics are correct"
    ip route | grep default
    _mw_sep

    # --- WiFi ---
    if [[ -n "$wintf" ]]; then
        _mw_hdr "ping 8.8.8.8 from Interface $wintf ($(_mw_ip $wintf))"
        ping -I "$wintf" -c 3 8.8.8.8
    else
        _mw_hdr "No wireless interface found — skipping WiFi ping"
    fi
    _mw_sep

    # --- Ethernet / bridge ---
    if [[ -d "/sys/class/net/$ethif" ]]; then
        _mw_hdr "ping 8.8.8.8 from Interface $ethif ($(_mw_ip $ethif))"
        ping -I "$ethif" -c 3 8.8.8.8
    else
        _mw_hdr "Interface $ethif not present — skipping Ethernet ping"
    fi
    _mw_sep

    # --- DNS ---
    _mw_hdr "Check DNS resolution"
    [[ -n "$wintf" ]] && resolvectl status "$wintf"
    printf "\n-------------------------------\n\n"
    [[ -d "/sys/class/net/$ethif" ]] && resolvectl status "$ethif"
}


alias mw-nplan-apply='sudo netplan apply'
alias mw-networkd-restart='systemctl restart networkd-dispatcher.service'
alias mw-nplan-edit='nohup sudo gnome-text-editor /etc/netplan/01-netcfg.yaml &'

# quick status display for br0
#alias mw-nplan-br0='sudo netplan apply && ip a show dev br0 && ip route | grep default'

# wait for an interface to get an IPv4 address (default 20s timeout)
_mw_wait_ip() {
    local ifc=$1 waited=0 max=${2:-40}
    until ip -4 addr show dev "$ifc" | grep -q "inet "; do
        sleep 0.5
        (( waited += 1 ))
        (( waited >= max )) && return 1
    done
}

mw-nplan-br0() {
    sudo netplan apply
    _mw_wait_ip br0 || echo "Timed out waiting for br0 IPv4."
    ip a show dev br0
    ip route | grep default
}


# switch netplan br0 between dhcp and static (enable/disable via file extension)
function mw-nplan_mode_switch() {
    local mode=$1
    local static_yaml="/etc/netplan/02-netcfg-static.yaml"
    local static_disabled="/etc/netplan/02-netcfg-static.disabled"
    local dhcp_yaml="/etc/netplan/01-netcfg-dhcp.yaml"
    local dhcp_disabled="/etc/netplan/01-netcfg-dhcp.disabled"

    case "$mode" in
        static)
            echo "Preparing Static IP configuration..."
            [[ -f "$dhcp_yaml" ]] && sudo mv "$dhcp_yaml" "$dhcp_disabled"
            [[ -f "$static_disabled" ]] && sudo mv "$static_disabled" "$static_yaml"
            sudo cp "$static_yaml" "$static_yaml.bak"   # <-- here: file is guaranteed active
            echo "Opening $static_yaml for review/edit. Close the editor when finished."
            # sudo gnome-text-editor "$static_yaml"
            sudo nano "$static_yaml"
            echo "Editor closed."
            ;;
        dhcp)
            echo "Preparing DHCP configuration..."
            [[ -f "$static_yaml" ]] && sudo mv "$static_yaml" "$static_disabled"
            [[ -f "$dhcp_disabled" ]] && sudo mv "$dhcp_disabled" "$dhcp_yaml"
            ;;
        *)
            echo "Usage: mw-nplan_mode_switch [static|dhcp]"
            return 1
            ;;
    esac

    # validate before applying — catches YAML typos without breaking networking
    if ! sudo netplan generate; then
        echo "netplan generate failed — config not applied. Fix the YAML and retry." >&2
        return 1
    fi

    sudo netplan apply

    # wait 10 seconds for br0 to get an address, but don't hang forever
    _mw_wait_ip br0 20 || echo "Timed out waiting for br0 to get an IPv4 address." >&2

    ip a show dev br0
    ip route | grep default
}

mw-mem-check() {
    echo "=== Memory statistics ==="
    free -h
    echo
    echo "=== Swap ==="
    swapon --show
    echo
    echo "=== OOM killer messages ==="
    sudo dmesg -T | grep -i "out of memory\|killed process"
    echo
    echo "=== Top memory consumers ==="
    \ps -eo pid,user,%mem,%cpu,rss,comm --sort=-%mem \
        | head -11 \
        | awk 'NR==1{print;next}{$5=$5*1024; print}' \
        | numfmt --header --field=5 --to=iec \
        | column -t
    echo
    read -q "reply?Do you want to run procs? (y/n) "
    echo
    if [[ $reply == [yY] ]]; then
        echo
        echo "=== procs full table ==="
        procs --sortd mem
    fi
}
