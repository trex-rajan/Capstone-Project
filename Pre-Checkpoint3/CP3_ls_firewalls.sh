#Firewall Settings to allow specific traffic on Server
#ESTABLISHED meaning that the packet is associated with a connection which has seen packets in both directions.
#RELATED meaning that the packet is starting a new connection

# Close everything and flush chains
echo "-------------------------------------------"
echo "Flush All Iptables Chains/Firewall rules"
iptables -F
 
echo "Delete all Iptables Chains"
echo "-------------------------------------------"
iptables -X

# Firewall Settings to allow specific traffic on Router INPUT chain
echo "-------------------------------------------"
echo "allow any INPUT tcp traffic if RELATED or ESTABLISHED"
iptables -A INPUT -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "-------------------------------------------"
echo "allow icmp traffic into the VM"
echo "icmp"
iptables -A INPUT -p icmp -j ACCEPT

echo "-------------------------------------------"
echo "allow any traffic from loopback interface into the VM"
echo "loopback"
iptables -A INPUT -i lo -j ACCEPT

echo "-------------------------------------------"
echo "allow any destination to access SSH traffic on port 22 into the VM"
echo "ssh"
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

echo "-------------------------------------------"
echo "allow to any destination to access HTTP traffic on port 80 into the VM"
echo "http"
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

echo "-------------------------------------------"
echo "allow to any destination to access MariaDB traffic on port 3306 into the VM"
echo "MySQL"
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT

echo "-------------------------------------------"
echo "reject all other INPUT traffic to this machine"
iptables -A INPUT -j DROP

echo "-------------------------------------------"
echo "allow any OUTPUT tcp traffic if RELATED or ESTABLISHED"
iptables -A OUTPUT -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "-------------------------------------------"
echo "allow to to access HTTP traffic on port 22 into the VM"
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT

echo "-------------------------------------------"
echo "allow to to access HTTP traffic on port 80 into the VM"
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT

echo "-------------------------------------------"
echo "allow icmp traffic from the VM"
iptables -A OUTPUT -p icmp -j ACCEPT

echo "-------------------------------------------"
echo "reject all other OUTPUT traffic from this machine"
iptables -A OUTPUT -j DROP

echo "-------------------------------------------"
echo "reject all FORWARD traffic from this machine"
iptables -A FORWARD -j DROP

echo "-------------------------------------------"
echo "list current iptables status"
iptables -nvL