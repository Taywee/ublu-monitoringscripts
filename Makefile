SOURCES = sysshep.alarm_msgw.ublu sysshep.nodiskstat.ublu sysshep.chkpprc.sh
SCRIPTS =  $(SOURCES:.ublu=.sh)

UBLU_JAR ?= /opt/ublu/ublu.jar
JAVA 	?= java

.PHONY: all clean

all: $(SCRIPTS)
clean:
	-rm $(SCRIPTS)


sysshep.alarm_msgw.sh : sysshep/alarm_msgw.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' -opt q QUSERNAME @qusername '$${' username to be monitored \(defaults to QSYSOPR\) '}$$' '$${' $@: monitors a user\'s message queue for messages waiting '}$$' $< '$${' sysshep.alarm_msgw \( @properties @qusername \) '}$$'

sysshep.nodiskstat.sh : sysshep/nodiskstat.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' '$${' $@: do monitoring when diskstat is not available, through db2 '}$$' $< '$${' sysshep.nodiskstat \( @properties \) '}$$'

sysshep.chkpprc.sh : sysshep/chkpprc.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -includepath '$$SCRIPTDIR' -optr p PROPERTIES @properties '$${' credentials properties file '}$$' -optr q ENV @env '$${' env to check '}$$' -optr q TYPE @type '$${' type to check '}$$' '$${' $@: run chkpprc and output an info or critical datapoint on the result '}$$' $< '$${' sysshep.chkpprc \( @properties @env @type \) '}$$'
