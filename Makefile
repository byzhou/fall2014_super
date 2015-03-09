default:all

#build dir
enc-build		:= submodules/encounter_tools/build
perl-build		:= submodules/lef_reformatting
matlab-build	:= submodules/matlab_imaging

#sampling info
startPoint		:= 0 
endPoint		:= 100 
stepSize		:= 10 

all: matlab 
tmp:
	tar -cvf gds.tar $(enc-build)/enc-par/current/*.gds
encounter:
	cd $(enc-build);\
	make enc-par;\
	cd -;
	tar -cvf gds.tar $(enc-build)/enc-par/current/*.gds

perl: encounter
	cp $(enc-build)/enc-par/current/*.def $(perl-build)/;\
	cd $(perl-build);\
	rm -rf $(perl-build)/txt/*.txt;\
	pwd;\
	./ext.pl $(startPoint) $(endPoint) $(stepSize) TjIn-Tj;\
	./ext.pl $(startPoint) $(endPoint) $(stepSize) TjIn;\
	cd -;
	tar -cvf txt.tar $(perl-build)/txt;\

matlab: perl
	rm -rf $(matlab-build)/txt/Tj*.txt;\
	rm -rf $(matlab-build)/Tj*.mat;\
	rm -rf $(matlab-build)/eps/*.eps;\
	cp $(perl-build)/txt/Tj*.txt $(matlab-build)/txt/.;\
	cd submodules/matlab_imaging/;\
	matlab -nodisplay -nosplash -r "top;quit;";\
	cd -;
	tar -cvf eps.tar $(matlab-build)/eps;\

clean:
	cd $(enc-build);\
	make clean ; \
	cd - ;\
	cd $(perl-build);\
	rm -rf txt/*.txt;\
	cd - ;\
	cd $(matlab-build);\
	rm -rf txt/Tj*.txt Tj*.mat eps/*.eps;\
	cd - ;\
	rm -rf *.tar ;\

		
