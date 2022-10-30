# allow all coming traffic by defualt
echo "iptables -P INPUT ACCEPT"
iptables -P INPUT ACCEPT

# allow all outgoing traffic by defualt
echo "iptables -P OUTPUT ACCEPT"
iptables -P OUTPUT ACCEPT

# do not allow any forwarded traffic by defualt
echo "iptables -P FORWARD DROP"
iptables -P FORWARD DROP