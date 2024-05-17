# Networking

What is the network?

According to Merriam-Webster, Network is usually an informally interconnected group or association of different entities like a person, computers, radio stations, etc.

For example, Dominos has a network of 1232 branches across India. As the name suggests the computer network is a system of peripherals or computers interconnected with each other and has a standard communication channel established between them to exchange different types of information and data.

How are Network types classified?
Network types can be classified and divided based on the area of distribution of the network. The below diagram would help to understand the same:

![alt text](image-20.png)

Explain LAN (Local Area Network)

LANs are widely used to connect computers/laptops and consumer electronics which enables them to share resources (e.g., printers, fax machines) and exchange information. When LANs are used by companies or organizations, they are called enterprise networks. There are two different types of LAN networks i.e. wireless LAN (no wires involved achieved using Wi-Fi) and wired LAN (achieved using LAN cable). Wireless LANs are very popular these days for places where installing wire is difficult. The below diagrams explain both wireless and wired LAN.

Tell me something about VPN (Virtual Private Network)

VPN or the Virtual Private Network is a private WAN (Wide Area Network) built on the internet. It allows the creation of a secured tunnel (protected network) between different networks using the internet (public network). By using the VPN, a client can connect to the organization’s network remotely

What are the advantages of using a VPN?

Below are few advantages of using VPN:

- VPN is used to connect offices in different geographical locations remotely and is cheaper when compared to WAN connections.
- VPN is used for secure transactions and confidential data transfer between multiple offices located in different geographical locations.
- VPN keeps an organization’s information secured against any potential threats or intrusions by using virtualization.
- VPN encrypts the internet traffic and disguises the online identity.

What are the different types of VPN?
Few types of VPN are:

- Access VPN: Access VPN is used to provide connectivity to remote mobile users and telecommuters. It serves as an alternative to dial-up connections or ISDN (Integrated Services Digital Network) connections. It is a low-cost solution and provides a wide range of connectivity.
- Site-to-Site VPN: A Site-to-Site or Router-to-Router VPN is commonly used in large companies having branches in different locations to connect the network of one office to another in different locations. There are 2 sub-categories as mentioned below:
- Intranet VPN: Intranet VPN is useful for connecting remote offices in different geographical locations using shared infrastructure (internet connectivity and servers) with the same accessibility policies as a private WAN (wide area network).
- Extranet VPN: Extranet VPN uses shared infrastructure over an intranet, suppliers, customers, partners, and other entities and connects them using dedicated connections.
7. What are nodes and links?

- Node: Any communicating device in a network is called a Node. Node is the point of intersection in a network. It can send/receive data and information within a network. Examples of the node can be computers, laptops, printers, servers, modems, etc.

- Link: A link or edge refers to the connectivity between two nodes in the network. It includes the type of connectivity (wired or wireless) between the nodes and protocols used for one node to be able to communicate with the other.

 What is the network topology?

Network topology is a physical layout of the network, connecting the different nodes using the links. It depicts the connectivity between the computers, devices, cables, etc.

9. Define different types of network topology

The different types of network topology are given below:

- Bus Topology:
All the nodes are connected using the central link known as the bus.
It is useful to connect a smaller number of devices.
If the main cable gets damaged, it will damage the whole network.

- Star Topology:
All the nodes are connected to one single node known as the central node.
It is more robust.
If the central node fails the complete network is damaged.
Easy to troubleshoot.
Mainly used in home and office networks.

- Ring topology
Each node is connected to exactly two nodes forming a ring structure
If one of the nodes are damaged, it will damage the whole network
It is used very rarely as it is expensive and hard to install and manage

- Mesh Topology:
Each node is connected to one or many nodes.
It is robust as failure in one link only disconnects that node.
It is rarely used and installation and management are difficult.

- Tree Topology:
A combination of star and bus topology also know as an extended bus topology.
All the smaller star networks are connected to a single bus.
If the main bus fails, the whole network is damaged.

- Hybrid:

It is a combination of different topologies to form a new topology.
It helps to ignore the drawback of a particular topology and helps to pick the strengths from other.

10. What is an IPv4 address? What are the different classes of IPv4?

An IP address is a 32-bit dynamic address of a node in the network. An IPv4 address has 4 octets of 8-bit each with each number with a value up to 255.

IPv4 classes are differentiated based on the number of hosts it supports on the network. There are five types of IPv4 classes and are based on the first octet of IP addresses which are classified as Class A, B, C, D, or E.

|IPv4 Class|IPv4 Start|IPv4 End Address|Usage|
|-|-|-|-|	
A |	0.0.0.0	    |127.255.255.255	|Used for Large Network
B |	128.0.0.0	|191.255.255.255	|Used for Medium Size Network
C |  192.0.0.0	|223.255.255.255	|Used for Local Area Network
D |	224.0.0.0	|239.255.255.255	|Reserved for Multicasting
E |	240.0.0.0	|255.255.255.254	|Study and R&D

11. What are Private and Special IP addresses?

Private Address: For each class, there are specific IPs that are reserved specifically for private use only. This IP address cannot be used for devices on the Internet as they are non-routable.

|IPv4 Class|	Private IPv4 Start Address|	Private IPv4 End Address|
|-|-|-|	
A|	10.0.0.0	|10.255.255.255
B|	172.16.0.0	|172.31.255.255
C|	192.168.0.0	|192.168.255.255

Special Address: IP Range from 127.0.0.1 to 127.255.255.255 are network testing addresses also known as loopback addresses are the special IP address.

Describe the OSI Reference Model

|Layer|	Unit Exchanged	|Description|
|-|-|-|	
Physical|	Bit	|- It is concerned with transmitting raw bits over a communication channel. - Chooses which type of transmission mode is to be selected for the transmission. The available transmission modes are Simplex, Half Duplex and Full Duplex.,
Data Link	|Frame|The main task of this layer is to transform a raw transmission facility into a line that appears free of undetected transmission errors. It also allows detecting damaged packets using the CRC (Cyclic Redundancy Check) error-detecting, code. When more than one node is connected to a shared link, Data Link Layer protocols are required to determine which device has control over the link at a given time. It is implemented by protocols like CSMA/CD, CSMA/CA, ALOHA, and Token Passing.
Network	|Packet	|It controls the operation of the subnet. The network layer takes care of feedback messaging through ICMP messages.
Transport|	TPDU - Transaction Protocol Data Unit|The basic functionality of this layer is to accept data from the above layers, split it up into smaller units if needed, pass these to the network layer, and ensure that all the pieces arrive correctly at the other end. The Transport Layer takes care of Segmentation and Reassembly.
Session	|SPDU - Session Protocol Data Unit	| The session layer allows users on different machines to establish sessions between them. Dialogue control is using the full-duplex link as half-duplex. It sends out dummy packets from the client to the server when the client is ideal.
Presentation|	PPDU - Presentation Protocol Data Unit	|The presentation layer is concerned with the syntax and semantics of the information transmitted.It translates a message from a common form to the encoded format which will be understood by the receiver.
Application	|APDU - Application Protocol Data Unit|	It contains a variety of protocols that are commonly needed by users.The application layer sends data of any size to the transport layer.

![alt text](image-21.png)

3. Describe the TCP/IP Reference Model
It is a compressed version of the OSI model with only 4 layers. It was developed by the US Department of Defence (DoD) in the 1980s. The name of this model is based on 2 standard protocols used i.e. TCP (Transmission Control Protocol) and IP (Internet Protocol).

4. Define the 4 different layers of the TCP/IP Reference Model

![alt text](image-25.png)


Layers of TCP/IP
Layer	|Description|
|-|-|
Link|	Decides which links such as serial lines or classic Ethernet must be used to meet the needs of the connectionless internet layer.
Internet| The internet layer is the most important layer which holds the whole architecture together. It delivers the IP packets where they are supposed to be delivered.
Transport|	Its functionality is almost the same as the OSI transport layer. It enables peer entities on the network to carry on a conversation.
Application|	It contains all the higher-level protocols.

OSI Vs TCP/IP

OSI Reference Model	|TCP/IP Reference Model
|-|-|
7 layered architecture|	4 layered architecture
Fixed boundaries and functionality for each layer|	Flexible architecture with no strict boundaries between layers
Low Reliability	| High Reliability
Vertical Layer Approach|	Horizontal Layer Approach

### HTTP and the HTTPS protocol?

HTTP is the HyperText Transfer Protocol which defines the set of rules and standards on how the information can be transmitted on the World Wide Web (WWW).  It helps the web browsers and web servers for communication. It is a ‘stateless protocol’ where each command is independent with respect to the previous command. HTTP is an application layer protocol built upon the TCP. It uses port 80 by default.

HTTPS is the HyperText Transfer Protocol Secure or Secure HTTP. It is an advanced and secured version of HTTP. On top of HTTP, SSL/TLS protocol is used to provide security. It enables secure transactions by encrypting the communication and also helps identify network servers securely. It uses port 443 by default.

### GET, POST, PUT, PATCH, DELTE

- GET The GET method is used to retrieve data from the server.
- POST The POST method sends data to the server and creates a new resource.
- PUT The PUT method is most often used to update an existing resource.
- PAtCH the request is very similar to the PUT request, but the body of the request contains only the property of the resource that needs to be changed. The response is the new version of the resource.
- DELETE The DELETE method is used to delete a resource specified by its URI.

### URI

URI (Uniform Resource Identifier) es una cadena de caracteres que identifica un recurso específico en la web. Es una secuencia de caracteres que proporciona un identificador único y global para un recurso, ya sea una página web, un archivo, un servicio, un fragmento de texto o cualquier otro recurso que pueda ser identificado.

La URI consta de dos partes principales:

URL (Uniform Resource Locator):

Una URL es un tipo de URI que especifica la ubicación de un recurso en la web, incluyendo el protocolo de acceso (como HTTP o HTTPS), el nombre del dominio o la dirección IP del servidor, y la ruta al recurso en el servidor. Por ejemplo, https://www.ejemplo.com/pagina.html es una URL que apunta a una página web llamada "pagina.html" en el servidor "www.ejemplo.com" utilizando el protocolo HTTPS.
URN (Uniform Resource Name):

Un URN es otro tipo de URI que proporciona un nombre único y persistente para un recurso, independientemente de su ubicación o acceso. A diferencia de una URL, que especifica dónde se puede encontrar un recurso, un URN simplemente proporciona un identificador único para el recurso. Ejemplos de URN incluyen ISBNs para libros y DOIs para documentos científicos.
En resumen, una URI es una cadena de caracteres que proporciona una identificación única y global para un recurso en la web, ya sea especificando su ubicación (URL) o proporcionando un nombre único (URN).

###  SMTP protocol

SMTP is the Simple Mail Transfer Protocol. SMTP sets the rule for communication between servers. This set of rules helps the software to transmit emails over the internet. It supports both End-to-End and Store-and-Forward methods. It is in always-listening mode on port 25.


### DNS

DNS is the Domain Name System. It is considered as the devices/services directory of the Internet. It is a decentralized and hierarchical naming system for devices/services connected to the Internet. It translates the domain names to their corresponding IPs. For e.g. interviewbit.com to 172.217.166.36. It uses port 53 by default.

9. What is the use of a router and how is it different from a gateway?

The router is a networking device used for connecting two or more network segments. It directs the traffic in the network. It transfers information and data like web pages, emails, images, videos, etc. from source to destination in the form of packets. It operates at the network layer. The gateways are also used to route and regulate the network traffic but, they can also send data between two dissimilar networks while a router can only send data to similar networks.

###  TCP protocol

TCP or TCP/IP is the Transmission Control Protocol/Internet Protocol. It is a set of rules that decides how a computer connects to the Internet and how to transmit the data over the network. It creates a virtual network when more than one computer is connected to the network and uses the three ways handshake model to establish the connection which makes it more reliable.

### UDP protocol

UDP is the User Datagram Protocol and is based on Datagrams. Mainly, it is used for multicasting and broadcasting. Its functionality is almost the same as TCP/IP Protocol except for the three ways of handshaking and error checking. It uses a simple transmission without any hand-shaking which makes it less reliable.

### Compare between TCP and UDP

TCP/IP	|UDP
|-|-|
Connection-Oriented Protocol	|Connectionless Protocol
More Reliable	| Less Reliable
Slower Transmission	|Faster Transmission
Packets order can be preserved or can be rearranged	|Packets order is not fixed and packets are independent of each other
Uses three ways handshake model for connection|	No handshake for establishing the connection
TCP packets are heavy-weight|	UDP packets are light-weight
Offers error checking mechanism |	No error checking mechanism
Protocols like HTTP, FTP, Telnet, SMTP, HTTPS, etc use TCP at the transport layer |	Protocols like DNS, RIP, SNMP, RTP, BOOTP, TFTP, NIP, etc use UDP at the transport layer

![alt text](image-22.png)

## ICMP protocol

ICMP is the Internet Control Message Protocol. It is a network layer protocol used for error handling. It is mainly used by network devices like routers for diagnosing the network connection issues and crucial for error reporting and testing if the data is reaching the preferred destination in time. It uses port 7 by default.

## DHCP Protocol

DHCP is the Dynamic Host Configuration Protocol.

It is an application layer protocol used to auto-configure devices on IP networks enabling them to use the TCP and UDP-based protocols. The DHCP servers auto-assign the IPs and other network configurations to the devices individually which enables them to communicate over the IP network. It helps to get the subnet mask, IP address and helps to resolve the DNS. It uses port 67 by default.

##  ARP protocol

ARP is Address Resolution Protocol. It is a network-level protocol used to convert the logical address i.e. IP address to the device's physical address i.e. MAC address. It can also be used to get the MAC address of devices when they are trying to communicate over the local network.

## FTP protocol

FTP is a File Transfer Protocol. It is an application layer protocol used to transfer files and data reliably and efficiently between hosts. It can also be used to download files from remote servers to your computer. It uses port 27 by default.

What is the MAC address and how is it related to NIC

MAC address is the Media Access Control address. It is a 48-bit or 64-bit unique identifier of devices in the network. It is also called the physical address embedded with Network Interface Card (NIC) used at the Data Link Layer. NIC is a hardware component in the networking device using which a device can connect to the network.

9Differentiate the MAC address with the IP address

The difference between MAC address and IP address are as follows:

MAC Address	|IP Address
|-|-|
Media Access Control Address|	Internet Protocol Address
6 or 8-byte hexadecimal number|	4 (IPv4) or 16 (IPv6) Byte address
It is embedded with NIC	| It is obtained from the network
Physical Address|	Logical Address
Operates at Data Link Layer|	Operates at Network Layer.
Helps to identify the device|	Helps to identify the device connectivity on the network.

## What is a subnet

A subnet is a network inside a network achieved by the process called subnetting which helps divide a network into subnets. It is used for getting a higher routing efficiency and enhances the security of the network. It reduces the time to extract the host address from the routing table.

## Compare the hub vs switch
Hub	|Switch
|-|-|
Operates at Physical Layer|	Operates at Data Link Layer
Half-Duplex transmission mode|	Full-Duplex transmission mode
Ethernet devices can be connectedsend|	LAN devices can be connected
Less complex, less intelligent, and cheaper	|Intelligent and effective
No software support for the administration|	Administration software support is present
Less speed up to 100 MBPS	|Supports high speed in GBPS
Less efficient as there is no way to avoid collisions when more than one nodes sends the packets at the same time|	More efficient as the collisions can be avoided or reduced as compared to Hub

What is the difference between the ipconfig and the ifconfig?

ipconfig	|ifconfig
|-|-|
Internet Protocol Configuration	|Interface Configuration
Command used in Microsoft operating systems to view and configure network interfaces	|Command used in MAC, Linux, UNIX operating systems to view and configure network interfaces
Used to get the TCP/IP summary and allows to changes the DHCP and DNS settings

##  firewall

The firewall is a network security system that is used to monitor the incoming and outgoing traffic and blocks the same based on the firewall security policies. It acts as a wall between the internet (public network) and the networking devices (a private network). It is either a hardware device, software program, or a combination of both. It adds a layer of security to the network.

## Unicasting, Anycasting, Multicasting and Broadcasting?

- Unicasting: If the message is sent to a single node from the source then it is known as unicasting. This is commonly used in networks to establish a new connection.
- Anycasting: If the message is sent to any of the nodes from the source then it is known as anycasting. It is mainly used to get the content from any of the servers in the Content Delivery System.
- Multicasting: If the message is sent to a subset of nodes from the source then it is known as multicasting. Used to send the same data to multiple receivers. 
- Broadcasting: If the message is sent to all the nodes in a network from a source then it is known as broadcasting. DHCP and ARP in the local network use broadcasting.

15. What happens when you enter google.com in the web browser?

Below are the steps that are being followed:

- Check the browser cache first if the content is fresh and present in cache display the same.
- If not, the browser checks if the IP of the URL is present in the cache (browser and OS) if not then request the OS to do a DNS lookup using UDP to get the corresponding IP address of the URL from the DNS server to establish a new TCP connection.
- A new TCP connection is set between the browser and the server using three-way handshaking.
- An HTTP request is sent to the server using the TCP connection.
- The web servers running on the Servers handle the incoming HTTP request and send the HTTP response.
- The browser process the HTTP response sent by the server and may close the TCP connection or reuse the same for future requests.
- If the response data is cacheable then browsers cache the same.
- Browser decodes the response and renders the content.

## DNS routing

![alt text](image-27.png)

![alt text](image-28.png)

![alt text](image-29.png)