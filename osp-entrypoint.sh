#!/bin/bash

# Start script for a containerized openschulportfolio
# for linuxmuster.net 6.2/7
# Frank Schiebel <frank@linuxmuster.net> 2019-03-14
#
# GPLv3
#

if [ $# -eq 0 ]; then 
	TEMPLATES="conf data"
	for tmpl in $TEMPLATES; do 
		tplcopy="no"
		[ "$(ls -A /var/www/html/${tmpl})" ] || tplcopy="yes"
		if [ ${tplcopy} == "yes" ]; then 
			echo -n "OSP-Setup: $tmpl is empty, copying template files to volume... "
			cp -ar /var/lib/openschulportfolio/${tmpl}/* /var/www/html/${tmpl}/
			chown -R www-data: /var/www/html/${tmpl}/
			echo " done."
		else
			echo -n "OSP-Setup: $tmpl is not empty, no changes made."
		fi
	done

	echo "Updating Plugins from container! ## FIXME Blacklist Plugins from compose!"
	cp -ar /var/lib/openschulportfolio/lib/plugins/* /var/www/html/lib/plugins/

	#Starting apache
	apache2-foreground
else
	# Start given command
	"$@"
fi

	       		
