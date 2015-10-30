sysctl -w net.ipv4.ip_forward=1
iptables -P FORWARD DROP
iptables -A FORWARD -i enp0s25 -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -j MASQUERADE
ip a a 192.168.0.1/24 dev enp0s25
