# Telefon-terror-importer
This is a script that fetches a list of numbers from telefonterror.no,a Norwegian database over spam numbers. 
It is nice to have those blacklisted.
That avoids pesky telemarketers,scammers and other annoyances.
It is for Norwegian users of  asterisk, it is a good idea to make a cronjob for this script,something like
0 4 * * 1 /dirtoscript/blacklist-import.sh That runs the script at 04:00 on Mondays.
It automatically downloads,updates the blacklist and removes old files.
The json adress string can be obtained from elefonterror.no . 
WARNING ! THIS SCRIPT IS UNTESTED ! PLEASE GET  USAGE PERMISSION AND THE RELEVANT JSON FILE ADRESS FROM TELEFONTERROR.NO!
IT WILL NOT WORK WITHOUT! 
