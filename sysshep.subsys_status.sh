# sysshep.subsys_status.sh: Check a single subsystem's status to make sure it matches a wanted status 
# autogenerated Wed Nov 01 16:00:35 MDT 2017 by taylor using command:
# gensh -to sysshep.subsys_status.sh -path /opt/ublu/ublu.jar -includepath $SCRIPTDIR -optr p PROPERTIES @properties ${ credentials properties file }$ -optr s SUBSYSPATH @subsyspath ${ path to a subsystem, like /QSYS.LIB/QINTER.SBSD }$ -optr w WANTEDSTATUS @wantedstatus ${ The desired status as an exact string, including the asterisk, like *ACTIVE }$ ${ sysshep.subsys_status.sh: Check a single subsystem's status to make sure it matches a wanted status }$ sysshep/subsys_status.ublu ${ sysshep.subsys_status ( @properties @subsyspath @wantedstatus ) }$

# Usage message
function usage {
echo "sysshep.subsys_status.sh: Check a single subsystem's status to make sure it matches a wanted status "
echo "This shell script was autogenerated Wed Nov 01 16:00:35 MDT 2017 by taylor."
echo "Usage: $0 [silent] [-h] [-X...] [-Dprop=val] -p PROPERTIES -s SUBSYSPATH -w WANTEDSTATUS"
echo "	where"
echo "	-h		display this help message and exit 0"
echo "	-X xOpt		pass a -X option to the JVM (can be used many times)"
echo "	-D some.property=\"some value\"	pass a property to the JVM (can be used many times)"
echo "	-p PROPERTIES	credentials properties file  (required option)"
echo "	-s SUBSYSPATH	path to a subsystem, like /QSYS.LIB/QINTER.SBSD  (required option)"
echo "	-w WANTEDSTATUS	The desired status as an exact string, including the asterisk, like *ACTIVE  (required option)"
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
while getopts p:s:w:D:X:h the_opt
do
	case "$the_opt" in
		p)	PROPERTIES="$OPTARG";;
		s)	SUBSYSPATH="$OPTARG";;
		w)	WANTEDSTATUS="$OPTARG";;
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
if [ "${SUBSYSPATH}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @subsyspath -trim \${ ${SUBSYSPATH} }$ "
else
	echo "Option -s SUBSYSPATH is a required option but is not present."
	usage
	exit 2
fi
if [ "${WANTEDSTATUS}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @wantedstatus -trim \${ ${WANTEDSTATUS} }$ "
else
	echo "Option -w WANTEDSTATUS is a required option but is not present."
	usage
	exit 2
fi

SCRIPTDIR=$(CDPATH= cd "$(dirname "$0")" && pwd)

# Prelude commands to execute before invocation
# No prelude commands

# Invocation
java${JVMOPTS}${JVMPROPS} -Dublu.includepath="$SCRIPTDIR" -jar /opt/ublu/ublu.jar ${gensh_runtime_opts} include ${SILENT}sysshep/subsys_status.ublu sysshep.subsys_status \( @properties @subsyspath @wantedstatus \) 
exit $?
