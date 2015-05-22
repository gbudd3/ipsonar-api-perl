test::
	(cd IPsonar; prove -l lib t/*.t)

clean::
	rm -fr tmp
	rm -fr IPsonar/blib

cpan:: clean test 
ifndef VERSION
		echo "Need to provide VERSION to make cpan"
		exit 2
endif
	mkdir tmp
	tar cf - ./IPsonar  | ( cd tmp; tar xf - )
	sed -i .bak s/#VER#/${VERSION}/ tmp/IPsonar/lib/IPsonar.pm
	sed -i .bak s/#HGID#/`hg id -i`/ tmp/IPsonar/lib/IPsonar.pm
	rm tmp/IPsonar/lib/*.bak
	tar --exclude=*.swp -czf IPsonar-$(VERSION).tgz -C tmp IPsonar
	rm -fr tmp
	

