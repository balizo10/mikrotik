
 /interface set "ether1" name="WAN1"
 /interface set "MINA" name="WANZ"

 /interface bridge add name="LAN_Bridge" disabled=no
 /interface bridge port add interface=ether4 bridge=LAN_Bridge

 
 /ip dhcp-client add interface=WAN1 use-peer-dns=yes add-default-route=yes disabled=no


 /ip pool add name=dhcp-pool ranges=10.10.10.10-10.10.10.254
 /ip dhcp-server network add address=10.10.10.0/24 gateway=10.10.10.1 dns-server=8.8.8.8
 /ip dhcp-server add interface=LAN_Bridge address-pool=dhcp-pool lease-time=4h disabled=no


/ip address add address=10.10.10.1/24 interface=LAN_Bridge


/ip firewall nat add chain=srcnat action=masquerade out-interface=WAN1


ip route add dst-address=0.0.0.0/0 gateway=192.168.1.1


 ip dns set servers=8.8.8.8 allow-remote-requests=yes

