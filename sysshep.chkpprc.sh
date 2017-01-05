# sysshep.chkpprc.sh: run chkpprc and output an info or critical datapoint on the result 
# autogenerated Thu Jan 05 16:40:24 MST 2017 by taylor using command:
# gensh -to sysshep.chkpprc.sh -path /opt/ublu/ublu.jar -includepath $SCRIPTDIR -optr p PROPERTIES @properties ${ credentials properties file }$ -optr e ENV @env ${ env to check }$ -optr t TYPE @type ${ type to check }$ ${ sysshep.chkpprc.sh: run chkpprc and output an info or critical datapoint on the result }$ sysshep/chkpprc.ublu ${ sysshep.chkpprc ( @properties @env @type ) }$

# Usage message
function usage {
echo "sysshep.chkpprc.sh: run chkpprc and output an info or critical datapoint on the result "
echo "This shell script was autogenerated Thu Jan 05 16:40:24 MST 2017 by taylor."
echo "Usage: $0 [silent] -h -p PROPERTIES -e ENV -t TYPE "
echo "	where"
echo "	-h		display this help message and exit 0"
echo "	-p PROPERTIES	credentials properties file  (required option)"
echo "	-e ENV	env to check  (required option)"
echo "	-t TYPE	type to check  (required option)"
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
while getopts p:e:t:h the_opt
do
	case "$the_opt" in
		p)	PROPERTIES="$OPTARG";;
		e)	ENV="$OPTARG";;
		t)	TYPE="$OPTARG";;
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
if [ "${ENV}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @env -trim \${ ${ENV} }$ "
else
	echo "Option -e ENV is a required option but is not present."
	usage
	exit 2
fi
if [ "${TYPE}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @type -trim \${ ${TYPE} }$ "
else
	echo "Option -t TYPE is a required option but is not present."
	usage
	exit 2
fi

SCRIPTDIR=$(CDPATH= cd "$(dirname "$0")" && pwd)

# Invocation
java -Dublu.includepath="$SCRIPTDIR" -jar /opt/ublu/ublu.jar ${gensh_runtime_opts} include ${SILENT}sysshep/chkpprc.ublu sysshep.chkpprc \( @properties @env @type \) 
exit $?
