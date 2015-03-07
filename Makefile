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

encounter:
	cd $(enc-build);\
	make enc-par;\
	cd -;

perl: encounter
	cp $(enc-build)/enc-par/current/*.def $(enc-build)/;\
	cd $(perl-build);\
	pwd;\
	./ext.pl $(startPoint) $(endPoint) $(stepSize);\
	cd -;

matlab: perl
	rm -rf $(matlab-build)/txt/HT*.txt;\
	rm -rf $(matlab-build)/HT*.mat;\
	rm -rf $(matlab-build)/eps/*.eps;\
	cp $(perl-build)/txt/HT*.txt $(matlab-build)/txt/.;\
	cd submodules/matlab_imaging/;\
	matlab -nodisplay -nosplash -r "top;quit;";\
	cd -;
	
