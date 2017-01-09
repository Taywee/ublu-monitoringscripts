SCRIPTS = sysshep.monitor.sh sysshep.monitor_nodisk.sh sysshep.msgq.sh sysshep.alarm_msgw.sh sysshep.nodiskstat.sh sysshep.chkpprc.sh

UBLU_JAR ?= /opt/ublu/ublu.jar
JAVA 	?= java

.PHONY: all clean

all: $(SCRIPTS)
clean:
	-rm $(SCRIPTS)

sysshep.monitor_nodisk.sh : sysshep/monitor_nodisk.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' '$${' $@: ordinary ublu monitoring, minus disk stats '}$$' $< '$${' sysshep.monitor_nodisk \( @properties \) '}$$'

sysshep.monitor.sh : sysshep/monitor.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' '$${' $@: ordinary ublu monitoring '}$$' $< '$${' sysshep.monitor \( @properties \) '}$$'

sysshep.alarm_msgw.sh : sysshep/alarm_msgw.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' -opt q QUSERNAME @qusername '$${' username to be monitored \(defaults to QSYSOPR\) '}$$' '$${' $@: monitors a user\'s message queue for messages waiting '}$$' $< '$${' sysshep.alarm_msgw \( @properties @qusername \) '}$$'

sysshep.msgq.sh : sysshep/msgq.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' -opt q QUSERNAME @qusername '$${' username to be monitored \(defaults to QSYSOPR\) '}$$' -optr t TIMEFILE @timefile '$${' temp file to store last timestamp in '}$$' '$${' $@: print all messages for message queue since the last check '}$$' $< '$${' sysshep.msgq \( @properties @qusername @timefile \) '}$$'

sysshep.nodiskstat.sh : sysshep/nodiskstat.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' '$${' $@: do monitoring when diskstat is not available, through db2 '}$$' $< '$${' sysshep.nodiskstat \( @properties \) '}$$'

sysshep.chkpprc.sh : sysshep/chkpprc.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' -optr e ENV @env '$${' env to check '}$$' -optr t TYPE @type '$${' type to check '}$$' '$${' $@: run chkpprc and output an info or critical datapoint on the result '}$$' $< '$${' sysshep.chkpprc \( @properties @env @type \) '}$$'
