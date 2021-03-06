# sysshep.msg_matches.sh: monitors a user's message queue for a message matching a regex pattern 
# autogenerated Fri Nov 09 11:23:55 MST 2018 by taylor using command:
# gensh -to sysshep.msg_matches.sh -path /opt/ublu/ublu.jar -includepath $SCRIPTDIR -optr p PROPERTIES @properties ${ credentials properties file }$ -opt q MSGQUEUE @msgqueue ${ msgqueue to be monitored (defaults to /qsys.lib/qsysopr.msgq) }$ -optr t TIMEFILE @timefile ${ temp file to store last timestamp in }$ -optr P PATTERN @pattern ${ Regex pattern to check message bodies for. This is not a search, it must match exactly, so you will likely need to use .+ or .* at the beginning and end. }$ -opt I IGNOREPATTERN @ignorepattern ${ Pattern specifying which messages to ignore. Again a regex match instead of a search, like -P }$ ${ sysshep.msg_matches.sh: monitors a user's message queue for a message matching a regex pattern }$ sysshep/msgq.ublu ${ sysshep.msg_matches ( @properties @msgqueue @timefile @pattern @ignorepattern ) }$

# Usage message
function usage {
echo "sysshep.msg_matches.sh: monitors a user's message queue for a message matching a regex pattern "
echo "This shell script was autogenerated Fri Nov 09 11:23:55 MST 2018 by taylor."
echo "Usage: $0 [silent] [-h] [-X...] [-Dprop=val] -p PROPERTIES [-q MSGQUEUE] -t TIMEFILE -P PATTERN [-I IGNOREPATTERN]"
echo "	where"
echo "	-h		display this help message and exit 0"
echo "	-X xOpt		pass a -X option to the JVM (can be used many times)"
echo "	-D some.property=\"some value\"	pass a property to the JVM (can be used many times)"
echo "	-p PROPERTIES	credentials properties file  (required option)"
echo "	-q MSGQUEUE	msgqueue to be monitored (defaults to /qsys.lib/qsysopr.msgq) "
echo "	-t TIMEFILE	temp file to store last timestamp in  (required option)"
echo "	-P PATTERN	Regex pattern to check message bodies for. This is not a search, it must match exactly, so you will likely need to use .+ or .* at the beginning and end.  (required option)"
echo "	-I IGNOREPATTERN	Pattern specifying which messages to ignore. Again a regex match instead of a search, like -P "
echo "---"
echo "If the keyword 'silent' appears ahead of all options, then included files will not echo and prompting is suppressed."
echo "Exit code is the result of execution, or 0 for -h or 2 if there is an error in processing options"
echo "This script sets \$SCRIPTDIR to the script's directory prior to executing prelude commands and Ublu invocation."
}

#Test if user wants silent includes
if [ "$1" == "silent" ]
then
	SILENT="-silent "
	shift
else
	SILENT=""
fi

# Process options
while getopts p:q:t:P:I:D:X:h the_opt
do
	case "$the_opt" in
		p)	PROPERTIES="$OPTARG";;
		q)	MSGQUEUE="$OPTARG";;
		t)	TIMEFILE="$OPTARG";;
		P)	PATTERN="$OPTARG";;
		I)	IGNOREPATTERN="$OPTARG";;
		h)	usage;exit 0;;
		D)	JVMPROPS="${JVMPROPS} -D${OPTARG}";;
		X)	JVMOPTS="${JVMOPTS} -X${OPTARG}";;
		[?])	usage;exit 2;;

	esac
done
shift `expr ${OPTIND} - 1`
if [ $# -ne 0 ]
then
	echo "Superfluous argument(s) $*"
	usage
	exit 2
fi

# Translate options to tuple assignments
if [ "${PROPERTIES}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @properties -trim \${ ${PROPERTIES} }$ "
else
	echo "Option -p PROPERTIES is a required option but is not present."
	usage
	exit 2
fi
if [ "${MSGQUEUE}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @msgqueue -trim \${ ${MSGQUEUE} }$ "
fi
if [ "${TIMEFILE}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @timefile -trim \${ ${TIMEFILE} }$ "
else
	echo "Option -t TIMEFILE is a required option but is not present."
	usage
	exit 2
fi
if [ "${PATTERN}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @pattern -trim \${ ${PATTERN} }$ "
else
	echo "Option -P PATTERN is a required option but is not present."
	usage
	exit 2
fi
if [ "${IGNOREPATTERN}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @ignorepattern -trim \${ ${IGNOREPATTERN} }$ "
fi

SCRIPTDIR=$(CDPATH= cd "$(dirname "$0")" && pwd)

# Prelude commands to execute before invocation
# No prelude commands

set -o noglob

# Invocation
java${JVMOPTS}${JVMPROPS} -Dublu.includepath="$SCRIPTDIR" -jar /opt/ublu/ublu.jar ${gensh_runtime_opts} include ${SILENT}sysshep/msgq.ublu sysshep.msg_matches \( @properties @msgqueue @timefile @pattern @ignorepattern \) 
exit $?
