- **COURSE INFORMATION: CSN400**

- **Student's Name: Keshav Raj Ghimire**

- **STUDENT'S NUMBER: 162575195**

- **GITHUB USER_ID: myseneca-62575195**

- **TEACHER’S NAME: Atoosa Nasiri**

- **ASSIGNMENT REF: Checkpoint2-Part1-Report**

## Table of Contents:




## List of VMs in Cloud Lab

```bash
 PS /home/odl_user>  az lab vm list  --lab-name CSN400-52 --resource-group Student-RG-734707
 Command group 'lab' is in preview and under development. Reference and support levels: https://aka.ms/CLI_refstatus
[]
PS /home/odl_user> 
```
## List of images in Cloud Lab

```bash
PS /home/odl_user> az lab custom-image list  --lab-name CSN400-52 --resource-group Student-RG-734707 --query "[ [].name , [].vm.sourceVmId ]"
Command group 'lab' is in preview and under development. Reference and support levels: https://aka.ms/CLI_refstatus
[
  [
    "LR-52ci-V1",
    "LS-52ci-V1",
    "WS-52ci-V1",
    "WC-52ci-V1",
    "LR-52ci-V2",
    "LS-52ci-V2",
    "WS-52ci-V2",
    "WC-52ci-V2"
  ],
  [
    "/subscriptions/e22a2bd0-d760-4866-9918-1c98f501eb6a/resourcegroups/student-rg-734707/providers/microsoft.devtestlab/labs/csn400-52/virtualmachines/lr-52",
    "/subscriptions/e22a2bd0-d760-4866-9918-1c98f501eb6a/resourcegroups/student-rg-734707/providers/microsoft.devtestlab/labs/csn400-52/virtualmachines/ls-52",
    "/subscriptions/e22a2bd0-d760-4866-9918-1c98f501eb6a/resourcegroups/student-rg-734707/providers/microsoft.devtestlab/labs/csn400-52/virtualmachines/ws-52",
    "/subscriptions/e22a2bd0-d760-4866-9918-1c98f501eb6a/resourcegroups/student-rg-734707/providers/microsoft.devtestlab/labs/csn400-52/virtualmachines/wc-52",
    "/subscriptions/e22a2bd0-d760-4866-9918-1c98f501eb6a/resourcegroups/student-rg-734707/providers/microsoft.devtestlab/labs/csn400-52/virtualmachines/lr-52",
    "/subscriptions/e22a2bd0-d760-4866-9918-1c98f501eb6a/resourcegroups/student-rg-734707/providers/microsoft.devtestlab/labs/csn400-52/virtualmachines/ls-52",
    "/subscriptions/e22a2bd0-d760-4866-9918-1c98f501eb6a/resourcegroups/student-rg-734707/providers/microsoft.devtestlab/labs/csn400-52/virtualmachines/ws-52",
    "/subscriptions/e22a2bd0-d760-4866-9918-1c98f501eb6a/resourcegroups/student-rg-734707/providers/microsoft.devtestlab/labs/csn400-52/virtualmachines/wc-52"
  ]
]
PS /home/odl_user> 


```

## Working Tree
```bash
rajan@Rajan:/mnt/d/Semester 4th/CSN400/Azure/CSN400-Capstone/Checkpoint2-Part1$ tree -a
.
├── config.sh
├── CP2_lr_firewalls.sh
├── CP2_ls_firewalls.sh
├── DevTestLab
│   ├── lr.json
│   ├── ls.json
│   ├── wc.json
│   └── ws.json
├── lab_vm_image.sh
├── lab_vm.sh
└── README.md

1 directory, 10 files
```

## Output of iptables -nvL
- Linux Router
```bash
  [krghimire@LR-52 ~]$ ls
CP2_lr_firewalls.sh  linuxrouter52
[krghimire@LR-52 ~]$ sudo ./CP2_lr_firewalls.sh
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
[krghimire@LR-52 ~]$
[krghimire@LR-52 ~]$
[krghimire@LR-52 ~]$
[krghimire@LR-52 ~]$ hostname
LR-52.csn50052.com
[krghimire@LR-52 ~]$ sudo iptables -nvL
Chain INPUT (policy ACCEPT 2177 packets, 435K bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain FORWARD (policy ACCEPT 1191 packets, 92594 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 3951 packets, 992K bytes)
 pkts bytes target     prot opt in     out     source               destination
[krghimire@LR-52 ~]$
```


- Linux Server
```bash
[krghimire@LS-52 ~]$ sudo ./CP2_ls_firewalls.sh
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP
[krghimire@LS-52 ~]$
[krghimire@LS-52 ~]$
[krghimire@LS-52 ~]$
[krghimire@LS-52 ~]$ hostname
LS-52.csn50052.com
[krghimire@LS-52 ~]$ sudo iptables -nvL
Chain INPUT (policy ACCEPT 1970 packets, 372K bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain FORWARD (policy DROP 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination

Chain OUTPUT (policy ACCEPT 3831 packets, 958K bytes)
 pkts bytes target     prot opt in     out     source               destination
[krghimire@LS-52 ~]$
```
