#!/bin/sh

VERSION="0.1"
PROGNAME="$(basename $0)"

CONFIG="$HOME/.spdns-client"

SPDNS_USER=""
SPDNS_PASS=""
SPDNS_HOST=""
SPDNS_IP="192.168.0.1"

if [ -f "$CONFIG" ]
then
    . "$CONFIG"
fi

print_usage () {
    cat <<EOT
Usage:	$PROGNAME -u <username> -p <password> -d <host> [-i <IP>]

Supported options:
    -h              print this help message
    -v              print version
    -u  <user>      username
    -p  <pass>      password
    -d  <host>      hostname
    -i  <IP>        IP address; if omitted or value is in private
                    subnet (10.0.0.0/8, 172.16.0.0/20 or 192.168.0.0/16)
                    the requesting IP is used

EOT
}

print_version () {
    echo "$PROGNAME $VERSION"
}

update_dns () {
    curl -s \
        -u "$SPDNS_USER":"$SPDNS_PASS" \
        -F "hostname=$SPDNS_HOST" \
        -F "myip=$SPDNS_IP" \
        http://www.spdns.de/nic/update
}

while getopts hvu:p:d:i: OPT; do
    case "$OPT" in
        h)
            print_version
            print_usage
            exit 0
            ;;
        v)
            print_version
            exit 0
            ;;
        u)
            SPDNS_USER="$OPTARG"
            ;;
        p)
            SPDNS_PASS="$OPTARG"
            ;;
        d)
            SPDNS_HOST="$OPTARG"
            ;;
        i)
            SPDNS_IP="$OPTARG"
            ;;
        \?)
            # getopts issues an error message
            print_version >&2
            print_usage >&2
            exit 1
            ;;
    esac
done

shift "$(expr $OPTIND - 1)"

if [ "$SPDNS_USER" = "" ] || [ "$SPDNS_PASS" = "" ] || [ "$SPDNS_HOST" = "" ] || [ "$SPDNS_IP" = "" ]
then
    print_version >&2
    print_usage >&2
    exit 1
fi

update_dns

# EOF
