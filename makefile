main: calendula.cbl vec3.cbl
	cobc -x -free -o calendula calendula.cbl vec3.cbl

clear:
	rm -f calendula *.ppm *.png
