# sysshep.sysdiskstat.sh: do monitoring when diskstat is not available, through db2 
# autogenerated Thu Jan 05 16:30:12 MST 2017 by taylor using command:
# gensh -to sysshep.sysdiskstat.sh -path /opt/ublu/ublu.jar -includepath $SCRIPTDIR -optr p PROPERTIES @properties ${ credentials properties file }$ ${ sysshep.sysdiskstat.sh: do monitoring when diskstat is not available, through db2 }$ sysshep/sysdiskstat.ublu ${ sysshep.sysdiskstat ( @properties ) }$

# Usage message
function usage {
echo "sysshep.sysdiskstat.sh: do monitoring when diskstat is not available, through db2 "
echo "This shell script was autogenerated Thu Jan 05 16:30:12 MST 2017 by taylor."
echo "Usage: $0 [silent] -h -p PROPERTIES "
echo "	where"
echo "	-h		display this help message and exit 0"
echo "	-p PROPERTIES	credentials properties file  (required option)"
echo "	-t THRESHOLD threshold for percent disk stat"
echo "---"
echo "If the keyword 'silent' appears ahead of all options, then included files will not echo and prompting is suppressed."
echo "Exit code is the result of execution, or 0 for -h or 2 if there is an error in processing options"
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
while getopts p:t:h the_opt
do
	case "$the_opt" in
		p)	PROPERTIES="$OPTARG";;
		t)	THRESHOLD="$OPTARG";;
		h)	usage;exit 0;;
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
if [ "${THRESHOLD}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @threshold -trim \${ ${THRESHOLD} }$ "
fi

SCRIPTDIR=$(CDPATH= cd "$(dirname "$0")" && pwd)

set -o noglob

# Invocation
java -Dublu.includepath="$SCRIPTDIR" -jar /opt/ublu/ublu.jar ${gensh_runtime_opts} include ${SILENT}sysshep/sysdiskstat.ublu sysshep.sysdiskstat \( @properties @threshold \) 
exit $?
