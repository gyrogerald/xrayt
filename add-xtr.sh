#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : JsPhantom
# (C) Copyright 2022
# =========================================
clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
MYIP=$(wget -qO- ipv4.icanhazip.com);
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
purple='\e[0;35m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cek=$( curl -sS https://raw.githubusercontent.com/tridebleng/permission/main/access | awk '{print $2}'  | grep $MYIP )
Name=$(curl -sS https://raw.githubusercontent.com/tridebleng/permission/main/access | grep $MYIP | awk '{print $4}')
if [[ $cek = $MYIP ]]; then
echo -e "${green}Permission Accepted...${NC}"
else
echo -e "${red}Permission Denied!${NC}";
echo ""
echo -e "Your IP is ${red}NOT REGISTER${NC} @ ${red}EXPIRED${NC}"
echo ""
echo -e "Please Contact ${green}Admin${NC}"
echo -e "Telegram : t.me/JsPhantom"
exit 0
fi
clear

BURIQ() {
    curl -sS https://raw.githubusercontent.com/tridebleng/permission/main/access >/root/tmp
    data=($(cat /root/tmp | grep -E "^### " | awk '{print $4}'))
    for user in "${data[@]}"; do
        exp=($(grep -E "^### $user" "/root/tmp" | awk '{print $3}'))
        d1=($(date -d "$exp" +%s))
        d2=($(date -d "$biji" +%s))
        exp2=$(((d1 - d2) / 86400))
        if [[ "$exp2" -le "0" ]]; then
            echo $user >/etc/.$user.ini
        else
            rm -f /etc/.$user.ini >/dev/null 2>&1
        fi
    done
    rm -f /root/tmp
}

MYIP=$(wget -qO- ipv4.icanhazip.com);
Name=$(curl -sS https://raw.githubusercontent.com/tridebleng/permission/main/access | grep $MYIP | awk '{print $4}')
echo $Name >/usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman() {
    if [[ -f "/etc/.$Name.ini" ]]; then
        CekTwo=$(cat /etc/.$Name.ini)
        if [[ "$CekOne" = "$CekTwo" ]]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION() {
    MYIP=$(wget -qO- ipv4.icanhazip.com);
    IZIN=$(curl -sS https://raw.githubusercontent.com/tridebleng/permission/main/access | awk '{print $2}' | grep $MYIP)
    if [[ "$MYIP" = "$IZIN" ]]; then
        Bloman
    else
        res="Permission Denied!"
    fi
    BURIQ
}
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION

clear
domain=$(cat /root/domain)
MYIP2=$(wget -qO- ipv4.icanhazip.com);
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
            echo -e "\033[0;34m╔============================================╗\033[0m"
            echo -e "\033[35;1m          Add XRAY Trojan TCP Account              \033[0m"
            echo -e "\033[0;34m╚============================================╝\033[0m"

		read -rp "Username : " -e user
		user_EXISTS=$(grep -w $user /usr/local/etc/xray/trojan.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
clear
		    echo -e "\033[0;34m╔============================================╗\033[0m"
            echo -e "\033[35;1m     Add XRAY Trojan TCP Account   \033[0m"
            echo -e "\033[0;34m╚============================================╝\033[0m"
			echo ""
			echo "A client with the specified name was already created, please choose another name."
			echo ""
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -n 1 -s -r -p "Press any key to back on menu"
			menu
		fi
	done

read -p "Bug Address (Example: www.google.com) : " address
read -p "Bug SNI/Host (Example : m.facebook.com) : " hst
read -p "Expired (days) : " masaaktif
bug_addr=${address}.
bug_addr2=${address}
if [[ $address == "" ]]; then
sts=$bug_addr2
else
sts=$bug_addr
fi
bug=${hst}
bug2=bug.com
if [[ $hst == "" ]]; then
sni=$bug2
else
sni=$bug
fi

uuid=$(cat /proc/sys/kernel/random/uuid)
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
sed -i '/#tr$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/trojan.json
trojanlink="trojan://${uuid}@${sts}${domain}:443?security=tls&type=tcp&allowInsecure=1&sni=${sni}#XRAY_TROJAN_TCP_${user}"
# // Restarting Service
systemctl restart xray@trojan.service
service cron restart

cat > /home/vps/public_html/$user-TRTCP.yaml <<EOF
port: 7890
socks-port: 7891
redir-port: 7892
mixed-port: 7893
tproxy-port: 7895
ipv6: false
mode: rule
log-level: silent
allow-lan: true
external-controller: 0.0.0.0:9090
secret: ""
bind-address: "*"
unified-delay: true
profile:
  store-selected: true
  store-fake-ip: true
dns:
  enable: true
  ipv6: false
  use-host: true
  enhanced-mode: fake-ip
  listen: 0.0.0.0:7874
  nameserver:
    - 8.8.8.8
    - 1.0.0.1
    - https://dns.google/dns-query
  fallback:
    - 1.1.1.1
    - 8.8.4.4
    - https://cloudflare-dns.com/dns-query
    - 112.215.203.254
  default-nameserver:
    - 8.8.8.8
    - 1.1.1.1
    - 112.215.203.254
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.localdomain"
    - "*.example"
    - "*.invalid"
    - "*.localhost"
    - "*.test"
    - "*.local"
    - "*.home.arpa"
    - time.*.com
    - time.*.gov
    - time.*.edu.cn
    - time.*.apple.com
    - time1.*.com
    - time2.*.com
    - time3.*.com
    - time4.*.com
    - time5.*.com
    - time6.*.com
    - time7.*.com
    - ntp.*.com
    - ntp1.*.com
    - ntp2.*.com
    - ntp3.*.com
    - ntp4.*.com
    - ntp5.*.com
    - ntp6.*.com
    - ntp7.*.com
    - "*.time.edu.cn"
    - "*.ntp.org.cn"
    - +.pool.ntp.org
    - time1.cloud.tencent.com
    - music.163.com
    - "*.music.163.com"
    - "*.126.net"
    - musicapi.taihe.com
    - music.taihe.com
    - songsearch.kugou.com
    - trackercdn.kugou.com
    - "*.kuwo.cn"
    - api-jooxtt.sanook.com
    - api.joox.com
    - joox.com
    - y.qq.com
    - "*.y.qq.com"
    - streamoc.music.tc.qq.com
    - mobileoc.music.tc.qq.com
    - isure.stream.qqmusic.qq.com
    - dl.stream.qqmusic.qq.com
    - aqqmusic.tc.qq.com
    - amobile.music.tc.qq.com
    - "*.xiami.com"
    - "*.music.migu.cn"
    - music.migu.cn
    - "*.msftconnecttest.com"
    - "*.msftncsi.com"
    - msftconnecttest.com
    - msftncsi.com
    - localhost.ptlogin2.qq.com
    - localhost.sec.qq.com
    - +.srv.nintendo.net
    - +.stun.playstation.net
    - xbox.*.microsoft.com
    - xnotify.xboxlive.com
    - +.battlenet.com.cn
    - +.wotgame.cn
    - +.wggames.cn
    - +.wowsgame.cn
    - +.wargaming.net
    - proxy.golang.org
    - stun.*.*
    - stun.*.*.*
    - +.stun.*.*
    - +.stun.*.*.*
    - +.stun.*.*.*.*
    - heartbeat.belkin.com
    - "*.linksys.com"
    - "*.linksyssmartwifi.com"
    - "*.router.asus.com"
    - mesu.apple.com
    - swscan.apple.com
    - swquery.apple.com
    - swdownload.apple.com
    - swcdn.apple.com
    - swdist.apple.com
    - lens.l.google.com
    - stun.l.google.com
    - +.nflxvideo.net
    - "*.square-enix.com"
    - "*.finalfantasyxiv.com"
    - "*.ffxiv.com"
    - "*.mcdn.bilivideo.cn"
    - +.media.dssott.com
proxies:
  - name: XRAY_TROJAN_TCP_${user}
    server: ${sts}${domain}
    port: 443
    type: trojan
    password: ${uuid}
    skip-cert-verify: true
    sni: ${sni}
    udp: true
proxy-groups:
  - name: JsPhantom-AUTOSCRIPT
    type: select
    proxies:
      - XRAY_TROJAN_TCP_${user}
      - DIRECT
rules:
  - MATCH,JsPhantom-AUTOSCRIPT
EOF

clear
echo -e ""
echo -e "════[XRAY TROJAN TCP]════"
echo -e "Remarks           : ${user}"
echo -e "Domain            : ${domain}"
echo -e "Port              : 443"
echo -e "Key               : ${uuid}"
echo -e "Network           : TCP"
echo -e "Security          : TLS"
echo -e "AllowInsecure     : True"
echo -e "═══════════════════"
echo -e "Link XRAY Trojan  : ${trojanlink}"
echo -e "═══════════════════"
echo -e "YAML XRAY Trojan  : http://${MYIP2}:81/$user-TRTCP.yaml"
echo -e "═══════════════════"
echo -e "Created On        : $hariini"
echo -e "Expired On        : $exp"
echo -e "═══════════════════"
echo -e ""
echo -e "Autoscript By JsPhantom"
echo -e ""�