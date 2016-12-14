SOURCES = sysshep.alarm_msgw.ublu sysshep.nodiskstat.ublu
SCRIPTS =  $(SOURCES:.ublu=.sh)

DIR 	 ?= $(shell pwd)
UBLU_JAR ?= /opt/ublu/ublu.jar
JAVA 	?= java

.PHONY: all clean

all: $(SCRIPTS)
clean:
	-rm $(SCRIPTS)


sysshep.alarm_msgw.sh : sysshep.alarm_msgw.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -optr p PROPERTIES @properties '$${' credentials properties file '}$$' -opt q QUSERNAME @qusername '$${' username to be monitored \(defaults to QSYSOPR\) '}$$' '$${' sysshep.alarm_msgw.sh: monitor's a user's message queue for messages waiting '}$$' $(DIR)/$< '$${' sysshep.alarm_msgw \( @properties @qusername \) '}$$'

sysshep.nodiskstat.sh : sysshep.nodiskstat.ublu
	$(JAVA) -jar $(UBLU_JAR) -silent gensh -to $@ -path $(UBLU_JAR) -optr p PROPERTIES @properties '$${' credentials properties file '}$$' '$${' sysshep.nodiskstat.sh: do monitoring when diskstat is not available, through db2 '}$$' $(DIR)/$< '$${' sysshep.nodiskstat \( @properties \) '}$$'
