# Checkpoint2 Configuration & Debugging Cheat-sheet

## Windows Client Installation (WC-xx)
Install the following applications using a web browser:
- Mozilla Firefox browser
- MySQL Client Shell
- Wireshark
- FileZilla FTP Client

Check the IP configuration:
```
ipconfig /all
```

## Windows Server Installation (WS-xx)
Install the following applications using a web browser:
- Mozilla Firefox browser
- Wireshark

Check the IP configuration:
```
ipconfig /all
```

## Linux Server Installation (LS-xx)
```bash
# Remove the firewalld service
sudo firewall-cmd --state
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo systemctl mask --now firewalld
sudo systemctl status firewalld

# Install iptables services
sudo yum install iptables-services
sudo systemctl enable iptables
sudo systemctl iptables

# Work with hostname
sudo hostnamectl status
sudo hostnamectl set-hostname LS-xx.CSN500xx.com #static

# Install tcpdump
sudo yum install tcpdump

# Run yum update
sudo yum update
```

## Linux Router Installation (LR-xx)
```bash
# Remove the firewalld service
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo yum remove firewalld

# Install iptables services
sudo yum install iptables-services
sudo systemctl enable iptables
sudo systemctl iptables

# Work with hostname
sudo hostnamectl status
sudo hostnamectl set-hostname LR-xx.csn500xx.com ##static

# Enable IPv4 forwarding
sudo echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/ip_forward
sudo net.ipv4.ip_forward > /proc/sys/net/ipv4/ip_forward

# Install tcpdump
sudo yum install tcpdump

# Run yum update
sudo yum update
```

Alternative method to Enable IP forwarding
```bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo vim /etc/sysctl.conf
net.ipv4.ip_forward = 1
sudo sysctl -p /etc/sysctl.conf
```

# Checkpoint2 Troubleshooting & Debugging 
## Checkpoint2 SSH to Linux VMs
[How to use SSH keys with Windows on Azure](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/ssh-from-windows)

Create an SSH key pair in ` powershell `
```powershell
ssh-keygen -m PEM -t rsa -b 2048
```
Create a VM using your key _not needed for any of the CSN400 CPs, just common knowledge_
```bash
az vm create \
   --resource-group myResourceGroup \
   --name myVM \
   --image UbuntuLTS\
   --admin-username azureuser \
   --ssh-key-value ~/.ssh/id_rsa.pub
```
Connect to your VM
```bash
ssh -i ~/.ssh/id_rsa azureuser@xxx.xxx.xxx.xxx
```

## Checkpoint2 Traffic Management Commands
This line specifies what traffic to look at in router machine when trying to ssh to server machine from another window:
```bash
# Look for Server Traffic in Router VM
sudo tcpdump -i any -qnns 0 host 172.17.xxx.37
```

Packet forwarding must be enabled in multiple locations for ssh to server to work properly. Also _Firewall_ could be causing issues. Make sure firewalls are disabled, check above commands to find the one for firewall status check.
```bash
sudo iptables -nvL
```
Make sure forwarding is enabled
```bash
cat /proc/sys/net/ipv4/ip_forward
```
Drop Chain FORWARD reject line
```bash
sudo iptables -D FORWARD 1
sudo systemctl restart iptables
```
Problem would be that after restarting `iptables` it seems FORWARD reject line is back in FORWARD chain rule. work around might be:
```bash
sudo iptables-save > /etc/sysconfig/iptables
```
Which return *Permission Denied*
```bash
sudo iptables-save | sudo tee /etc/sysconfig/iptables
sudo systemctl restart iptables
```

## Checkpoint2 Advanced Debugging & Troubleshooting
If You happen to flush iptables in router, then you lose it all:
```bash
sudo iptables -F
```
From the admin user Scott runs: (NBB-week6-session1-@1:28)
``` bash
az vm run-command invoke -g Student-RG-634489 -n LR-120 -command-id RunShellScript --scripts "iptabes -P INPUT ACCEPT"

az vm run-command invoke -g csn500-1-LR-1-xxx -n LR-120 -command-id RunShellScript --scripts "iptabes -P INPUT ACCEPT"
```

Also check [nic_IP_config.sh](./nic_IP_cofig.sh) for Enabling the IP forwarding in NIC of Router after it is created --> need it for CP3
```bash
echo "nic forwarding enable ... "
az network nic update --name  $NIC_LR  --resource-group $RG_Name --ip-forwarding true 2>/dev/null
```
Directly injecting commands into a running VM without ssh-ing ot rdp-ing into it. Thi  is not something you want to do continuously but the last resort if all goes north pole.


## Checkpoint2 Working with iptables
You need to use the following syntax:
sudo iptables -I chain [rule-number] firewall-rule

To view rules:
sudo iptables -t filter -L chain --line-numbers -n -v

Capturing traffic to file
```
sudo iptables -I FORWARD -p all -m limit --limit 10/s -j LOG
```
```
cat /var/log/messages
```
---
### Useful Links
- [IPTables](https://wiki.centos.org/HowTos/Network/IPTables)
