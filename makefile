main: calendula.cbl vec3.cbl
	cobc -x -free -o calendula calendula.cbl vec3.cbl

run:
	./calendula

clear:
	rm -f calendula *.ppm *.png
