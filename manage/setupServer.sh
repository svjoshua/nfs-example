#!/bin/bash
if [ `whoami` != "root" ]; then
	echo "Script must be executed as root"
	exit 1
fi
TITLE='[35m'
INPUT='[32m'
RESET='[0m'

echo -e "\e${TITLE} -=Setup NFS Example=- \e${RESET}"
echo -e "\e${TITLE} -System Prep \e${RESET}"
apt-get update -y

echo -e "\e${TITLE} -Install NFS \e${RESET}"
apt install nfs-kernel-server -y

echo -e "\e${TITLE} -Configure NFS \e${RESET}"
cp /sv/config/nfs-kernel-server /etc/default/nfs-kernel-server
cp /sv/config/nfs-common /etc/default/nfs-common
cp /sv/config/exports /etc/exports

echo -e "\e${TITLE} -Mounting /sv/files \e${RESET}"
#ln -s /sv/files /files
cp -R /sv/files /files
chmod -R 777 /files

echo -e "\e${TITLE} -Start NFS \e${RESET}"
systemctl start nfs-kernel-server.service
service nfs-kernel-server restart

echo -e "\e${TITLE} -=End Setup=- \e${RESET}"
