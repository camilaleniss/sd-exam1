yum install -y telnet-server
yum install -y telnet
systemctl start firewalld
systemctl status firewalld
firewall-cmd --permanent --add-port=23/tcp
firewall-cmd --zone=public --add-service=telnet --permanent
firewall-cmd --reload
systemctl start telnet.socket
systemctl enable telnet.socket
useradd cas
passwd cas 

cas 
cas 
usermod -G root cas 
groups cas 

echo ++++ **Script install telnet and Firewall finished** ++++




