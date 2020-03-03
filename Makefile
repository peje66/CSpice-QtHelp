SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

cspice.qch : cspice.qhp
	qhelpgenerator  -o $@  $^

cspice.qhp : $(SELF_DIR)cspice.qhp.in keywords.txt files.txt
	# replace content of keywords.txt & files.txt into target
	sed -e "/TAG_SECTIONS_XYZ/r sections.txt" -e "/TAG_SECTIONS_XYZ/d" \
	    -e "/TAG_VERSION_XYZ/r version.txt" -e "/TAG_VERSION_XYZ/d" \
	    -e "/TAG_KEYWORDS_XYZ/r keywords.txt" -e "/TAG_KEYWORDS_XYZ/d" \
	    -e "/TAG_FILES_XYZ/r files.txt" -e "/TAG_FILES_XYZ/d" $< > $@

.PHONY : keywords.txt files.txt sections.txt version.txt
version.txt : ../../exe/version
	$^ > $@
sections.txt : index.html
	sed -ne '/href/ s/.*href=\("[^"]*"\)[^>]*>\([^<]*\).*/<section title="\2" ref=\1 \/>/p' index.html > $@
keywords.txt :
	# Collect keywords
	for i in *.html cspice/*.html; \
	do \
		fn=$$(basename $$i .html); \
		echo '<keyword name="'$$fn'" id="cspice::'$$fn'" ref="'$$i'#Procedure"/>'; \
		awk -f $(SELF_DIR)keywords.awk $$i; \
	done | sort > $@

files.txt :
	# collect all html-files
	for i in *.html */*.html; do echo '<file>'$$i'</file>'; done > $@

test :
	assistant -register cspice.qch
	assistant
	assistant -unregister cspice.qch
