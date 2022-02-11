#!/bin/bash

echo "-------------------------------------------"
echo "Ubuntu 20.04 desktop auto install"
echo "root 123456"
echo "-------------------------------------------"

sleep 5

echo root:123456 |sudo chpasswd root
sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart

sudo apt update -y
sudo apt install ubuntu-desktop -y
sudo apt install xrdp -y

sudo sed -i '$a\greeter-show-manual-login=true\nallow-guest=false' /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
sudo sed -i 's/^.*root quiet_success.*/\# auth required pam_succeed_if.so user \!\= root quiet_success/g' /etc/pam.d/gdm-autologin
sudo sed -i 's/^.*root quiet_success.*/\# auth required pam_succeed_if.so user \!\= root quiet_success/g' /etc/pam.d/gdm-password
sudo sed -i 's/^.*mesg.*/tty -s\&\&mesg n || true/g' /root/.profile

echo "root 123456"
echo "Finish! Please reboot!"
sleep 5
