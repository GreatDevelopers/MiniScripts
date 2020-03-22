for i in $*
do
	python3 remove_red_color.py $i
	filename=$(basename "$i")
	convert "${filename%.*}_output.png" -colorspace GRAY -negate -lat 20x20+4% -negate "${filename%.*}_output.png"
	python3 enhance_image.py "${filename%.*}_output.png"
done
