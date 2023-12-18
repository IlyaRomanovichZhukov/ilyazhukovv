#!/bin/bash
file="/etc/passwd"
login=""
flag=0
for arg in "$@"
do
	if [[ $arg == "-f" ]]
	then
	 	flag=1
		continue
	else
		if (( $flag==1 ))
		then
			file=$arg
			flag=0
		else
		login=$arg
		fi
	fi
done

if  [[ ! -e "$file" ]]
then
	echo "Файл не найден" >&2
	exit 2
fi

if ! grep -q "^$login:" "$file"
then
	echo "Пользователь не найден" >&2
	exit 1
fi

line=$( grep "^$login:" "$file" )
home=$(echo $line | cut -d ":" -f 6)
echo $home

