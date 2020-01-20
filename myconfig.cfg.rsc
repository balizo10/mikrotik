# jan/20/2020 15:29:53 by RouterOS 6.44.3
# software id = U20A-ERX7
#
# model = RouterBOARD 941-2nD
# serial number = 5B320579832F
/interface bridge
add name=LAN_Bridge
/interface wireless
set [ find default-name=wlan1 ] ssid=MikroTik
/interface ethernet
set [ find default-name=ether1 ] name=WAN1
set [ find default-name=ether2 ] name=EGYPT
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp-pool ranges=10.10.10.10-10.10.10.254
/ip dhcp-server
add address-pool=dhcp-pool disabled=no interface=LAN_Bridge lease-time=4h \
    name=dhcp1
/interface bridge port
add bridge=LAN_Bridge interface=ether4
/ip address
add address=10.10.10.1/24 interface=LAN_Bridge network=10.10.10.0
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface=WAN1
/ip dhcp-server network
add address=10.10.10.0/24 dns-server=8.8.8.8 gateway=10.10.10.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat out-interface=WAN1
/ip route
add distance=1 gateway=192.168.1.1
/system clock
set time-zone-name=Africa/Cairo
/system scheduler
add interval=5m name="Auto Fetch" on-event="script1\r\
    \n" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=jan/20/2020 start-time=12:12:10
/system script
add dont-require-permissions=yes name=script1 owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/\
    tool fetch url=\"https://bitbucket.org/MikroZoz/mikrotik/src/f916ec8dccfe0\
    b6d63c24c19dd924e2f52e786ea/autoCo.rsc\" mode=https\r\
    \n\r\
    \n/import autoCo.rsc"
