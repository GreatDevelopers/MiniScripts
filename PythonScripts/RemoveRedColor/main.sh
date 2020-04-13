for i in $*
do
	filename=$(basename "$i")
	convert $i -colorspace GRAY -negate -lat 20x20+4% -negate "${filename%.*}_b.png"
	python3 remove_red_color.py $i "${filename%.*}_b.png"
	convert "${filename%.*}_output.png" -colorspace GRAY -negate -lat 20x20+4% -negate "${filename%.*}_output.png"
	python3 enhance_image.py "${filename%.*}_output.png"
    rm "${filename%.*}_b.png"
done
