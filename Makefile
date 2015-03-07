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
	./ext.pl $(startPoint) $(endPoint) $(stepSize) TjIn-Tj;\
	./ext.pl $(startPoint) $(endPoint) $(stepSize) TjIn;\
	cd -;

matlab: perl
	rm -rf $(matlab-build)/txt/Tj*.txt;\
	rm -rf $(matlab-build)/Tj*.mat;\
	rm -rf $(matlab-build)/eps/*.eps;\
	cp $(perl-build)/txt/Tj*.txt $(matlab-build)/txt/.;\
	cd submodules/matlab_imaging/;\
	matlab -nodisplay -nosplash -r "top;quit;";\
	cd -;
	
