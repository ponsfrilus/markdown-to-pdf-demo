all: sample onepdfwithallfonts demo

listfont:
	fc-list : family | cut -f1 -d"," | sort | uniq | tee fonts_list.txt

sample: listfont clearoutput clearunicodefontlist clearonepdfwithallfonts
	rm -f input/sample_tmp.md;
	while read -r font; \
	do \
		cp input/sample.md input/sample_tmp.md; \
		sed -i -e "s/{{FONTNAME}}/$$font/g" input/sample_tmp.md; \
		# Note: add "" | tee /dev/tty)" to the next command to see output \
		OUTP=$$(pandoc input/sample_tmp.md --pdf-engine=xelatex -V mainfont="$$font" -V urlcolor=cyan -V papersize:a4paper -V monofont="$$font" -V geometry:vmargin=2cm -V geometry:hmargin=2.5cm -o output/"$$font sample.pdf" 2>&1); \
		WARN=$$(echo $$OUTP | grep "\[WARNING\] Missing character: There is no"); \
		if [ -z "$$WARN" ]; \
			then \
				echo "\"$$font\" OK with unicode"; \
				echo "$$font" >> fonts_unicode_capable.txt; \
			else \
				echo "\"$$font\" NOT OK with unicode"; \
				echo "$$font" >> fonts_unicode_uncapable.txt; \
		fi; \
	done < fonts_list.txt; \
	rm input/sample_tmp.md;
	$(MAKE) onepdfwithallfonts


demo: cleardemo
	for filename in ./input/*.md; do \
		echo "Processing $$filename with Arial and Courier New"; \
		pandoc $$filename --pdf-engine=xelatex -V mainfont="Arial" -V urlcolor=cyan -V papersize:a4paper -V monofont="Courier New" -V geometry:vmargin=2cm -V geometry:hmargin=2.5cm -o output/demo/DejaVu_$$(basename "$$filename" .md).pdf 2>&1; \
		echo "Processing $$filename with DejaVu Sans and DejaVu Sans Mono"; \
		pandoc $$filename --pdf-engine=xelatex -V mainfont="DejaVu Sans" -V urlcolor=cyan -V papersize:a4paper -V monofont="DejaVu Sans Mono" -V geometry:vmargin=2cm -V geometry:hmargin=2.5cm -o output/demo/DejaVu_$$(basename "$$filename" .md).pdf 2>&1; \
		echo "Processing $$filename with FreeSans and FreeMono"; \
		pandoc $$filename --pdf-engine=xelatex -V mainfont="FreeSans" -V urlcolor=cyan -V papersize:a4paper -V monofont="FreeMono" -V geometry:vmargin=2cm -V geometry:hmargin=2.5cm -o output/demo/Free_$$(basename "$$filename" .md).pdf 2>&1; \
		echo "Processing $$filename with Liberation Sans and Liberation Mono"; \
		pandoc $$filename --pdf-engine=xelatex -V mainfont="Liberation Sans" -V urlcolor=cyan -V papersize:a4paper -V monofont="Liberation Mono" -V geometry:vmargin=2cm -V geometry:hmargin=2.5cm -o output/demo/Liberation_$$(basename "$$filename" .md).pdf 2>&1; \
		echo "Processing $$filename with Noto Sans CJK JP and Noto Sans Mono CJK JP"; \
		pandoc $$filename --pdf-engine=xelatex -V mainfont="Noto Sans CJK JP" -V urlcolor=cyan -V papersize:a4paper -V monofont="Noto Sans Mono CJK JP" -V geometry:vmargin=2cm -V geometry:hmargin=2.5cm -o output/demo/Noto_$$(basename "$$filename" .md).pdf 2>&1; \
		echo "Processing $$filename with Ubuntu and Ubuntu Mono"; \
		pandoc $$filename --pdf-engine=xelatex -V mainfont="Ubuntu" -V urlcolor=cyan -V papersize:a4paper -V monofont="Ubuntu Mono" -V geometry:vmargin=2cm -V geometry:hmargin=2.5cm -o output/demo/Ubuntu_$$(basename "$$filename" .md).pdf 2>&1; \
	done

onepdfwithallfonts:
	pdftk output/*.pdf cat output all_fonts.pdf

clearonepdfwithallfonts:
	rm -rf all_fonts.pdf

clearoutput:
	rm -rf output/*.pdf

cleardemo:
	rm -rf output/demo/*.pdf

clearunicodefontlist:
	rm -rf fonts_unicode_capable.txt fonts_unicode_uncapable.txt
