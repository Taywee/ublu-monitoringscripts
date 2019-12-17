# sysshep.job_active.sh: Check a list of jobs and generate info datapoints if active and alert datapoints if inactive 
# Ublu 1.2.1+ gensh autogenerated this shell script Tue May 14 10:28:14 MDT 2019 for jwoehr using command:
# gensh -to sysshep.job_active.sh -path /opt/ublu/ublu.jar -includepath $SCRIPTDIR -optr p PROPERTIES @properties ${ credentials properties file }$ -optr j JOBNAMELIST @jobnamelist ${ list of jobs e.g. "THISJOB THATJOB:" }$ -optr t JOBTYPE @jobtype ${ job type BATCH or INTERACTIVE }$ ${ sysshep.job_active.sh: Check a list of jobs and generate info datapoints if active and alert datapoints if inactive }$ sysshep/job_active.ublu ${ sysshep.job_active ( @properties @jobnamelist @jobtype ) }$

# Usage message
function usage {
echo "sysshep.job_active.sh: Check a list of jobs and generate info datapoints if active and alert datapoints if inactive "
echo "Ublu gensh autogenerated this shell script Tue May 14 10:28:14 MDT 2019 for jwoehr."
echo "Usage: $0 [glob] [silent] [-h] [-X...] [-Dprop=val] -p PROPERTIES -j JOBNAMELIST -t JOBTYPE"
echo "	where"
echo "	-h		display this help message and exit 0"
echo "	-X xOpt		pass a -X option to the JVM (can be used many times)"
echo "	-D some.property=\"some value\"	pass a property to the JVM (can be used many times)"
echo "	-p PROPERTIES	credentials properties file  (required option)"
echo "	-j JOBNAMELIST	list of jobs e.g. "THISJOB THATJOB:"  (required option)"
echo "	-t JOBTYPE	job type BATCH or INTERACTIVE  (required option)"
echo "---"
echo "If the keyword 'glob' appears ahead of all other options and arguments, only then will arguments be globbed by the executing shell (noglob default)."
echo "If the keyword 'silent' appears ahead of all options (except 'glob' if the latter is present), then included files will not echo and prompting is suppressed."
echo "Exit code is the result of execution, or 0 for -h or 2 if there is an error in processing options."
echo "This script sets \$SCRIPTDIR to the script's directory prior to executing prelude commands and Ublu invocation."
}

# Test if user wants arguments globbed - default noglob
if [ "$1" == "glob" ]
then
	set +o noglob # POSIX
	shift
else
	set -o noglob # POSIX
fi

# Test if user wants silent includes
if [ "$1" == "silent" ]
then
	SILENT="-silent "
	shift
else
	SILENT=""
fi

# Process options
while getopts p:j:t:D:X:h the_opt
do
	case "$the_opt" in
		p)	PROPERTIES="$OPTARG";;
		j)	JOBNAMELIST="$OPTARG";;
		t)	JOBTYPE="$OPTARG";;
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
if [ "${JOBNAMELIST}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @jobnamelist -trim \${ ${JOBNAMELIST} }$ "
else
	echo "Option -j JOBNAMELIST is a required option but is not present."
	usage
	exit 2
fi
if [ "${JOBTYPE}" != "" ]
then
	gensh_runtime_opts="${gensh_runtime_opts}string -to @jobtype -trim \${ ${JOBTYPE} }$ "
else
	echo "Option -t JOBTYPE is a required option but is not present."
	usage
	exit 2
fi

SCRIPTDIR=$(CDPATH= cd "$(dirname "$0")" && pwd)

# Prelude commands to execute before invocation
# No prelude commands

# Invocation
java${JVMOPTS}${JVMPROPS} -Dublu.includepath="$SCRIPTDIR" -jar /opt/ublu/ublu.jar ${gensh_runtime_opts} include ${SILENT}sysshep/job_active.ublu sysshep.job_active \( @properties @jobnamelist @jobtype \) 
exit $?