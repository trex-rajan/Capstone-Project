- **COURSE INFORMATION: CSN400**
- **Pre-Checkpoint3**

## TABLE OF CONTENTS

- [TABLE OF CONTENTS](#table-of-contents)
- [Iptables of Linux router](#iptables-of-linux-router)
- [Screenshot of iptables from router](#screenshot-of-iptables-from-router)
- [Iptables for linux Server VM](#iptables-for-linux-server-vm)
- [Screenshot of iptables from Linux server](#screenshot-of-iptables-from-linux-server)
- [Conclusion](#conclusion)


## Iptables of Linux router

- This is the following iptales configured for the router. The main purpose of iptables in this router is to forward the traffic to servers (windows and client). We have rules to allow different kind of traffci (i.e. tcp, udp, mysql, ssh, https, http, etc.)

```bash
sudo iptables -nvL
Chain INPUT (policy ACCEPT 690 packets, 157K bytes)
 pkts bytes target     prot opt in     out     source               destination
 2179  503K ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0
    0     0 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
    0     0 ACCEPT     tcp  --  *      *       10.11.119.0/24       0.0.0.0/0            state NEW tcp dpt:22
    6   456 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain FORWARD (policy ACCEPT 2145 packets, 184K bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            172.17.52.36         tcp dpt:53
    0     0 ACCEPT     tcp  --  *      *       172.17.52.36         0.0.0.0/0            tcp spt:53
    0     0 ACCEPT     udp  --  *      *       0.0.0.0/0            172.17.52.36         udp dpt:53
    0     0 ACCEPT     udp  --  *      *       172.17.52.36         0.0.0.0/0            udp spt:53
    0     0 ACCEPT     tcp  --  *      *       10.11.119.0/24       172.17.52.36         tcp dpt:3389
    0     0 ACCEPT     tcp  --  *      *       172.17.52.36         10.11.119.0/24       tcp spt:3389
    0     0 ACCEPT     tcp  --  *      *       10.11.119.0/24       172.17.52.37         tcp dpt:3306
    0     0 ACCEPT     tcp  --  *      *       172.17.52.37         10.11.119.0/24       tcp spt:3306
    0     0 ACCEPT     tcp  --  *      *       10.11.119.0/24       172.17.52.37         tcp dpt:80
    0     0 ACCEPT     tcp  --  *      *       172.17.52.37         10.11.119.0/24       tcp spt:80
    0     0 ACCEPT     tcp  --  *      *       10.11.119.0/24       172.17.52.36         tcp dpt:80
    0     0 ACCEPT     tcp  --  *      *       172.17.52.36         10.11.119.0/24       tcp spt:80
    0     0 ACCEPT     tcp  --  *      *       10.11.119.0/24       172.17.52.36         tcp dpt:21
    0     0 ACCEPT     tcp  --  *      *       172.17.52.36         10.11.119.0/24       tcp spt:21
    0     0 ACCEPT     tcp  --  *      *       10.11.119.0/24       172.17.52.36         tcp dpts:40001:40010
    0     0 ACCEPT     tcp  --  *      *       172.17.52.36         10.11.119.0/24       tcp spts:40001:40010
   36  6690 ACCEPT     tcp  --  *      *       10.11.119.0/24       172.17.52.37         tcp dpt:22
   39  7710 ACCEPT     tcp  --  *      *       172.17.52.37         10.11.119.0/24       tcp spt:22

Chain OUTPUT (policy ACCEPT 28151 packets, 7108K bytes)
 pkts bytes target     prot opt in     out     source               destination
[krghimire@lr-52 ~]$
```

## Screenshot of iptables from router

![screenshot for iptables not available!!!](./screenshot%20of%20iptables%20-nvL.jpg)



## Iptables for linux Server VM
- Well most of the traffic is controlled by the firewall of the linux router, so we are only configuring the input rule and output rule of the iptables. 
  
```bash
sudo iptables -nvL
Chain INPUT (policy ACCEPT 1319 packets, 151K bytes)
 pkts bytes target     prot opt in     out     source               destination
   80  4524 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0
    0     0 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:22
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:80
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:3306
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0

Chain OUTPUT (policy ACCEPT 1210 packets, 211K bytes)
 pkts bytes target     prot opt in     out     source               destination
   61  7548 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            state RELATED,ESTABLISHED
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:22
    0     0 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:80
    0     0 ACCEPT     icmp --  *      *       0.0.0.0/0            0.0.0.0/0
    4   240 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0
[krghimire@LS-52 ~]$ ls
CP3_ls_firewalls.sh
[krghimire@LS-52 ~]$
```


## Screenshot of iptables from Linux server
![Screenshot of iptables from  the server not available](./screenshot%20of%20iptables%20-%20server.jpg "iptables from the server")


## Conclusion
- This lab taught me how to create iptables rule to control the different types of traffic between clients and server. We can implement the same type of configuration while working for different companies in the future. It is also a method of securing our servers from unncessary traffic that can lead to different security threats like DDos.
