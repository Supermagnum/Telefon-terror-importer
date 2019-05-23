#!/bin/bash
#This is a script that fetches a list of numbers from telefonterror.no,a Norwegian database over spam numbers. 
#It is nice to have those blacklisted.
#That avoids pesky telemarketers,scammers and other annoyances.
#It is for asterisk, it is a good idea to make a cronjob for this script,something like
#0 4 * * 1 /dirtoscript/blacklist-import.sh That runs the script at 04:00 on Monday.
#It automatically downloads,updates the blacklist and removes old files.
#The json adress string can be obtained from telefonterror.no . Just write a email and ask. 
#WARNING ! THIS SCRIPT IS UNTESTED ! PLEASE GET  USAGE PERMISSION AND THE RELEVANT JSON FILE ADRESS FROM TELEFONTERROR.NO!
#IT WILL NOT WORK WITHOUT! 
cli="/usr/sbin/asterisk -rx"
dump=/tmp/blacklist.backup
blacklist=/tmp/latest_cc_blacklist.txt

#gets the list of phone numbers that are blacklisted from telefonterror.no
wget #JSON file string from telefonterror.no goes here, it typically ends in /all_numbers.json
#gets all relevant information from the json file and copies it to the relevant file. 
cat all_numbers.json | jq -j '.telefonnumre[]|"+",.landskode,.telefon,";",.firma,"\n"' >latest_cc_blacklist.txt
#removes downloaded json file to conserve file space 
rm all_numbers.json

 
echo "Dumping old blacklist to $dump"
$cli "database show blacklist" &amp;gt; $dump
 
if [ "$1" == "-d" ]; then
  echo "Removing all existing blacklist entries"
  $cli "database deltree blacklist"
fi
 
cat latest_cc_blacklist.txt | while read line; do
  [[ $line = \#* ]] &amp;amp;&amp;amp; continue
  number=${line%;*}
  desc=${line#*;}
  echo "database put blacklist $number \"$desc\""
  $cli "database put blacklist $number \"$desc\""
done
