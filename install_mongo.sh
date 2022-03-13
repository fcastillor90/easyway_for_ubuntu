#!/bin/bash
function update(){
	apt-get update -y
	apt-get upgrade -y
	apt-get autoremove -y
}

update > /dev/null

apt-get install gnupg -y
if [ $(arch) == 'x86_64' ]; then archtype=[arch=amd64]; fi

function install_mongo(){
	echo "---> Creando APT Source  ... "
	text="deb ${archtype} https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/5.0 multiverse"
	echo $text >> /etc/apt/sources.list.d/mongodb.list
	echo "---> MongoDB Key ... "
	wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
	echo "---> Actualizando ... "
	update > /dev/null
	echo "---> Instalando Paquetes ... "
	apt-get install mongodb mongodb-clients -y > /dev/null
	echo ""
}

function security_mongo(){
	echo "---> Configurando Firewall  ... "
	ufw allow 27017/tcp

}

function mongo_gui(){
	echo "---> Instalando Paquetes  ... "
	apt-get install  gconf-service gconf-service-backend gconf2-common libgconf-2-4 -y > /dev/null
	echo "---> Descargando Instalador ... "
	wget -q https://downloads.mongodb.com/compass/mongodb-compass_1.30.1_amd64.deb
	echo "---> Instalando Mongo Compass  ... "
	dpkg -i mongodb-compass_1.30.1_amd64.deb > /dev/null
}

echo "Instalando MongoDB ..."
#install_mongo
#security_mongo
mongo_gui
echo "Enjoy 3:)"
