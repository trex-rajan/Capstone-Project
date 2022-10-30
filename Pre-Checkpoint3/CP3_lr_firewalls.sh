# Close everything and flush chains
echo "-------------------------------------------"
echo "Flush All Iptables Chains/Firewall rules"
iptables -F
 
echo "Delete all Iptables Chains"
iptables -X

# Firewall Settings to allow specific traffic on Router INPUT chain
echo "-------------------------------------------"
echo "allow any INPUT tcp traffic if RELATED or ESTABLISHED"
iptables -A INPUT -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "-------------------------------------------"
echo "allow icmp traffic into the VM"
iptables -A INPUT -p icmp -j ACCEPT

echo "-------------------------------------------"
echo "allow any traffic from loopback interface into the VM"
iptables -A INPUT -i lo -j ACCEPT

echo "-------------------------------------------"
echo "ssh"
echo "allow destination SSH traffic on port 22 from Source IP subnet student_vnet into the VM"
iptables -A INPUT -p tcp -s 10.11.119.0/24 -m state --state NEW --dport 22 -j ACCEPT 

echo "-------------------------------------------"
echo "reject all other INPUT traffic to this machine"
iptables -A INPUT -j DROP

# Firewall Settings to allow specific traffic on Router FORWARD chain
echo "-------------------------------------------"
echo "DNS"
echo "allow any tcp and udp traffic pass through Linux router for DNS protocol"
# iptables -I FORWARD -p tcp --dport 53 -m limit --limit 10/s -j LOG --log-prefix "DNS-"
iptables -A FORWARD -p tcp -d 172.17.52.36 --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp -s 172.17.52.36 --sport 53 -j ACCEPT
iptables -A FORWARD -p udp -d 172.17.52.36 --dport 53 -j ACCEPT
iptables -A FORWARD -p udp -s 172.17.52.36 --sport 53 -j ACCEPT

echo "-------------------------------------------"
echo "RDP"
echo "allow any tcp and  udp traffic pass through source WC-52 subnet to destination WS-52 for destination rdp protocol"
iptables -A FORWARD -p tcp -s 10.11.119.0/24 -d 172.17.52.36 --dport 3389 -j ACCEPT
echo "allow any tcp and udp traffic pass through Source WS-52 to Destination WC-52 subnet for source rdp protocol"
iptables -A FORWARD -p tcp -d 10.11.119.0/24 -s 172.17.52.36 --sport 3389 -j ACCEPT

echo "-------------------------------------------"
echo "MySQL"
echo "allow any tcp traffic pass through Source WC-52 subnet to Destination LS-52 for destination MySQL protocol"
iptables -A FORWARD -p tcp -s 10.11.119.0/24 -d 172.17.52.37 --dport 3306 -j ACCEPT
echo "allow any tcp traffic pass through Source WS-52 to destination WC-xxsubnet for source MySQL protocol"
iptables -A FORWARD -p tcp -d 10.11.119.0/24 -s 172.17.52.37 --sport 3306 -j ACCEPT

echo "-------------------------------------------"
echo "Apache"
echo "allow any tcp traffic pass through Source WC-52 subnet to Destination WS-52 for destination Apache protocol"
iptables -A FORWARD -p tcp -s 10.11.119.0/24 -d 172.17.52.37 --dport 80 -j ACCEPT
echo "allow any tcp traffic pass through Source WS-52 to destination WC-52 subnet for source Apache protocol"
iptables -A FORWARD -p tcp -d 10.11.119.0/24 -s 172.17.52.37 --sport 80 -j ACCEPT

echo "-------------------------------------------"
echo "IIS"
echo "allow any tcp traffic pass through Source WC-52 subnet to Destination LR-52 for destination HTTP protocol to access IIS"
iptables -A FORWARD -p tcp -s 10.11.119.0/24 -d 172.17.52.36 --dport 80 -j ACCEPT
echo "allow any tcp traffic pass through Source LS-52 to destination WC-52 subnet for source HTTP protocol to access IIS"
iptables -A FORWARD -p tcp -d 10.11.119.0/24 -s 172.17.52.36 --sport 80 -j ACCEPT

echo "-------------------------------------------"
echo "FTP Administration Port"
echo "allow any tcp traffic pass through Source WC-52 subnet to Destination LR-52 for destination FTP protocol"
iptables -A FORWARD -p tcp -s 10.11.119.0/24 -d 172.17.52.36 --dport 21 -j ACCEPT
echo "allow any tcp traffic pass through Source LS-52 to destination WC-52 subnet for source FTP protocol"
iptables -A FORWARD -p tcp -d 10.11.119.0/24 -s 172.17.52.36 --sport 21 -j ACCEPT

echo "-------------------------------------------"
echo "FTP DATA Port"
echo "allow any tcp traffic pass through Source WC-52 subnet to Destination LR-52 for destination FTP protocol"
iptables -A FORWARD -p tcp -s 10.11.119.0/24 -d 172.17.52.36 --dport 40001:40010 -j ACCEPT
echo "allow any tcp traffic pass through Source LS -52 to destination WC-52 subnet for source FTP protocol"
iptables -A FORWARD -p tcp -d 10.11.119.0/24 -s 172.17.52.36 --sport 40001:40010 -j ACCEPT

echo "-------------------------------------------"
echo "SSH"
echo "allow any tcp traffic pass through Source WC-52 subnet to Destination LR-52 for destination SSH protocol"
iptables -A FORWARD -p tcp -s 10.11.119.0/24 -d 172.17.52.37 --dport 22 -j ACCEPT
echo "allow any tcp traffic pass through Source LS-52 to destination WC-52 subnet for source SSH protocol"
iptables -A FORWARD -p tcp -d 10.11.119.0/24 -s 172.17.52.37 --sport 22 -j ACCEPT

echo "-------------------------------------------"
echo "reject all FORWARD traffic from this machine"
iptables -A FORWARD DROP

echo "-------------------------------------------"
echo "list current iptables status"
iptables -nvL