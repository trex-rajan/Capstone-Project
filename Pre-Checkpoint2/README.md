# Pre-Checkpoint2 Submission

- **COURSE INFORMATION📋: CSN400(Computer Systems Project)**
- **STUDENT’S NAME :student: : Keshav Raj Ghimire**
- **STUDENT'S NUMBER🔢: 162575195**
- **GITHUB USER_ID🆔: myseneca-162575195**
- **TEACHER’S NAME👩‍🏫: Atoosa Nasiri**
---
---
## Table of Contents




### DevTest Lab Configuration
**Below is my DevTest Lab Configuration**

1. Screenshot of Overview of DevTest Lab, CSN400-52
   ![Network Topology image not found.](../Pre-Checkpoint2/DevTestConfigurationOverview.jpg)

2. Screenshots of Policies & Configuration - Allowed VMSKU & User Per VM:
     ![Screenshot not available at this moment.](VirtualMachineSKU&VMperUSer.jpg)
3. Screenshots of Policies & Configuration - Allowed Vnets & Lab Settings:
   ![Screenshot not avalable at this moment.](Lab%20Setting%20and%20Virtual%20Networks.jpg)

### Step by step guide to create and configure each of you VMs through Portal


**Below are the steps used to create and configure each of my VMs**

* Windows VM (WC-52)

1. Go to Home> Search for the DevTest Lab that you created and move to Lab > Click My Virtual machines under My Lab > Add > Choose `Windows 10 Pro, version 21H2` > fillup mandatory field (*). Unselect :Use a saved Secret". Then Fillup apppropriate passwords. > Select Advanced Settings> Choose "Student-734707-vnet" and leave rest as default.
    
    - We are creating resrouces inside the DevTestLab because all the VMs we create outside of the lab will not implement the policies and configurations we set up for DevTest Environment. It limits our options and make resource creation extremly easier.

* Linux VM (LR-52)
1. Go to Home > Search for DevTest Lab that you created and Select > Click my Virtual machines > Add > Choose `Red Hat Enterprise Linux 8.1` > fillup required fields  > Choose `SSH Public Key` as Authentication Type > Uncheck "Use a saved Secred" > Configure ssh to connect with your Linux Router > Go to Advanced Settings > Choose "Router-52"

   * To connect with ssh, we have to create a key pair using any linux machine (Azure CLI can work as well) using this following command: `ssh-keygen -m PEM -t rsa -b 2048`
   * Paste the contents of public key into the "SSH public key" box
   * Keep private key in a secure location which we will use to connect with our Linux VMs

* Linux Server (LS-52)
   
1. Follow the same steps to Create LS-52 and use the same key pairs for this VM as well but please change things below ### Very Important ###
   
   * Name: LS-52
   * VNET: Server - 52
  
* Windows Server (WS-52)
  
1. Follow the same steps to Create LS-52 and make this minor but ###VERY IMPORTANT ### changes:
   * Name: WS-52
   * VNET: Server - 52