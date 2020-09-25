#!/usr/bin/env bash

#Show colored text
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

defaultLocalPort=7002
defaultRemotePort=7003
defaultRemoteUser=$USER
defaultRemoteServer="192.168.0.112"

while [[ "$#" -gt 0 ]]; do
    case $1 in
    -lp | --localPort)
        localPort=$2
        shift
        ;;
    -rp | --remotePort)
        remotePort=$2
        shift
        ;;
    -u | --remoteUser | --user)
        remoteUser=$2
        shift
        ;;
    -s | --remoteServer | --server)
        remoteServer=$2
        shift
        ;;
    esac
    shift
done

if [ -z "$localPort" ]; then
    printf "Local Port [${GREEN} ${defaultLocalPort} ${NC}]: "
    read localPort
    if [ -z "$localPort" ]; then
        localPort=$defaultLocalPort
    fi
fi

if [ -z "$remotePort" ]; then
    printf "Remote Port [${GREEN} ${defaultRemotePort} ${NC}]: "
    read remotePort
    if [ -z "$remotePort" ]; then
        remotePort=$defaultRemotePort
    fi
fi

if [ -z "$remoteUser" ]; then
    printf "Remote User [${GREEN} ${defaultRemoteUser} ${NC}]: "
    read remoteUser
    if [ -z "$remoteUser" ]; then
        remoteUser=$defaultRemoteUser
    fi
fi

if [ -z "$remoteServer" ]; then
    printf "Remote Server [${GREEN} ${defaultRemoteServer} ${NC}]: "
    read remoteServer
    if [ -z "$remoteServer" ]; then
        remoteServer=$defaultRemoteServer
    fi
fi

ssh -R \*:$remotePort:localhost:$localPort -N $remoteUser@$remoteServer
