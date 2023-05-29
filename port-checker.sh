#!/bin/bash
#Check if there is a change in your LISTENing ports.

logFile="/var/log/openPorts"

if [ ! -f $logFile ] ;
then
netstat -l | grep LISTEN | grep -v unix > $logFile;
echo $logFile
fi


originHash=$(md5sum -t $logFile | cut -f 1 -d " "); 
newHash=$(netstat -l | grep LISTEN | grep -v unix | md5sum -t | cut -f 1 -d " ");

if [ $originHash != $newHash ];
then
echo "Change in listening ports have been detected"
netstat -l | grep LISTEN | grep -v unix | tee $logFile
else
echo "The ports list did not change"
fi
