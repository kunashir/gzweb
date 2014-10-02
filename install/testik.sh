#!/bin/bash

DEPLOYER='quercus'

# if deployer not defined sets it current_user
if [ -z "$DEPLOYER" ]
then
  export DEPLOYER=$(whoami)
fi

echo -e "\033[31;47m Start deploying by $DEPLOYER \033[0m"


#creating file in sudoers.d (need for get nopasswd access to deployer)
file="/etc/sudoers.d/allow_access_for_$DEPLOYER"

if [ -f "$file" ]
then
	echo "access file found."
else
	echo "access file not found."
	tmp_file="/tmp/allow_access_for_$DEPLOYER"

	#if temp file exists - delete him
	if [ -f "$tmp_file" ]
	then
		sudo rm $tmp_file
	fi
	#creating temp access file
	sudo touch $tmp_file
	#set him mode to 0440
	sudo chmod 0440 $tmp_file
	#write string to this
	sudo sh -c "echo '$DEPLOYER ALL=(ALL:ALL) ALL, NOPASSWD: /usr/sbin/service nginx stop, /usr/sbin/service nginx restart, /usr/sbin/service start' >> $tmp_file"
	#copy temp file to sudoers.d
	sudo cp $tmp_file $file
	#remove temp file
	sudo rm $tmp_file
fi




# for (( ; ; ))
# do
#    echo "infinite loops [ hit CTRL+C to stop]"
# done



#
	# install git and nginx
# sudo apt-get install postgresql-9.1 libpq-dev git nginx

# echo "(ALL:ALL), NOPASSWD: /etc/sbin/service nginx restart" > allow access
# sudo chmod allow_access
# sudo mv allow_access /etc/sudoers.d/
#
