SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

cspice.qch : cspice.qhp
	qhelpgenerator  -o $@  $^

cspice.qhp : $(SELF_DIR)cspice.qhp.in keywords.txt files.txt
	# replace content of keywords.txt & files.txt into target
	sed  -e "/KEYWORDS/r keywords.txt" -e "/KEYWORDS/d" -e "/FILES/r files.txt" -e "/FILES/d" $< > $@

.PHONY : keywords.txt files.txt
keywords.txt :
	# Collect keywords
	for i in *.html cspice/*.html; \
	do \
		fn=$$(basename $$i .html); \
		echo '<keyword name="'$$fn'" id="'$$fn'" ref="'$$i'#Procedure"/>'; \
		awk -f $(SELF_DIR)keywords.awk $$i; \
	done > $@

files.txt :
	# collect all html-files
	for i in *.html */*.html; do echo '<file>'$$i'</file>'; done > $@

test :
	assistant-qt4 -register cspice.qch
	assistant-qt4
	assistant-qt4 -unregister cspice.qch