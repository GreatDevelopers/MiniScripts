for i in $*
do
	python3 remove_red_color.py $i
	filename=$(basename "$i")
	convert "${filename%.*}_output.png" -colorspace GRAY -negate -lat 20x20+6% -negate "${filename%.*}_output.png"
done
