#! /bin/sh

DEFAULT_LOG_HIT_COUNT=5
DEFAULT_LOG_SCAN_RANGE=500

HitCount=
ScanRange=
LogType=

argc="$#"

show_usage() {
	local cmd=`basename $0`
	cat << EOF
Usage: $cmd --count <count> --range <range> --log [txn|poc|gen|chl|wit]

-h|--help         - show this help text
-c|--count NUM    - stop after NUM selected lines (default: 5)
-r|--range NUM    - log scan range (default: 500)
-l|--log          - show <txn,poc,gen> errors
-l|--log txn      - show Transaction related errors
-l|--log poc      - show POC related errors
-l|--log gen      - show General errors
-l|--log chl      - show Challenge logs
-l|--log wit      - show Witnessed logs

EOF
}

debug() {
	cat << EOF
HitCount:  $HitCount
ScanRange: $ScanRange
LogType:   $LogType
EOF
}

do_init() {
	if [ "$argc" -lt 1 ]; then
		show_usage
		exit 1
	fi
}

do_getopt() {
	argv=$(getopt --name `basename $0` --options 'c:r:l::h' --longoptions 'log::,count:,range:,help' -- "$@") 2>&1
	if [ "$?" != "0" ]; then
		show_usage
		exit 1
	fi
	eval "set -- ${argv}"
	#echo "debug> [$argv]"

	while true; do
		case "$1" in
		-h|--help) show_usage; exit 0;;
		-c|--count) HitCount=$2;  shift 2;;
		-r|--range)	ScanRange=$2; shift 2;;
		-l|--log)
			case "${2,,}" in
				"")	   LogType="ALL";    shift 2;;
				"txn") LogType="${2,,}"; shift 2;;
				"poc") LogType="${2,,}"; shift 2;;
				"gen") LogType="${2,,}"; shift 2;;
				"chl") LogType="${2,,}"; shift 2;;
				"wit") LogType="${2,,}"; shift 2;;
				*)     show_usage;        exit 1;;
			esac
			;;
		"--") shift; break;;
		*)    show_usage; exit 1;;
		esac
	done
}

parm_normalize() {
	HitCount=${HitCount:-$DEFAULT_LOG_HIT_COUNT}
	ScanRange=${ScanRange:-$DEFAULT_LOG_SCAN_RANGE}
	LogType=${LogType:-"ALL"}
}

do_main() {
	#do_init
	do_getopt "$@"
	parm_normalize
	debug
}

do_main "$@"

