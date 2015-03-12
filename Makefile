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
	tar -cvf gds.tar $(enc-build)/enc-par/current/*.gds $(enc-build)/enc-par/current/*.map 

perl: 
	cp $(enc-build)/enc-par/current/*.def $(perl-build)/def;\
	cd $(perl-build);\
	rm -rf $(perl-build)/txt/*.txt;\
	pwd;\
	./ext.pl $(startPoint) $(endPoint) $(stepSize) TjIn-Tj;\
	./ext.pl $(startPoint) $(endPoint) $(stepSize) TjIn;\
	./shi_ext.pl $(startPoint) $(endPoint) $(stepSize) TjIn-Tj;\
	./shi_ext.pl $(startPoint) $(endPoint) $(stepSize) TjIn;\
	cd -;
	tar -cvf txt.tar $(perl-build)/txt;\

rep:
	cd $(perl-build);\
	pwd;\
	./rep.pl;\
	cd -

matlab: 
	rm -rf $(matlab-build)/txt/Tj*.txt;\
	rm -rf $(matlab-build)/shi/Tj*.txt;\
	rm -rf $(matlab-build)/Tj*.mat;\
	rm -rf $(matlab-build)/HT*.mat;\
	rm -rf $(matlab-build)/pdf/*.pdf;\
	cp $(perl-build)/txt/Tj*.txt $(matlab-build)/txt/.;\
	cp $(perl-build)/shi/Tj*.txt $(matlab-build)/shi/.;\
	cd submodules/matlab_imaging/;\
	matlab -nodisplay -nosplash -r "top;quit" ;\
	cd -;
	tar -cvf pdf.tar $(matlab-build)/pdf;\
	tar -cvf shi-pdf.tar $(matlab-build)/shi-pdf;\

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

		
