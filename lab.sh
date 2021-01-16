#!/usr/bin/env bash

#Get file name for security
read -p "What is downloaded file name ? " FILE
#Get Student ID
read -p "What is the student id ? " stud
#Get Ip address
read -p "What is the IP Address ? " ipaddr
# Check if the directory has access for script and give the permissions required
if [ "$(stat -c '%a' /usr/local/src)" -ne "777" ]
then
  chmod 777 /home/dre/labwork/Downloads/
  chmod 600 /home/dre/labwork/Downloads/$FILE
else
  chmod 600 /home/dre/labwork/Downloads/$FILE
fi

PS3="Select an operation :"
select opt in Upload Download Terminal Quit
do
      case $opt in
          "Upload") #Upload files to lab
            scp -r -i /home/dre/labwork/Downloads/$FILE /home/dre/labwork/testlab/*.py $stud@$ipaddr:/home/$stud
            ;;
          "Download") #Download files from lab
            scp -rp -i /home/dre/labwork/Downloads/$FILE $stud@$ipaddr:/home/$stud /home/dre/labwork
            ;;
          "Terminal") #Open Terminal session
            ssh -i /home/dre/labwork/Downloads/$FILE $stud@$ipaddr
#            ssh -i ~/Downloads/qwikLABS-XXXXX.pem username@External Ip Address
            ;;
          "Quit")
            break
            ;;
          *) echo "invalid option $REPLY";;
       esac
done

