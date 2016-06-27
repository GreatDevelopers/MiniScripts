# Creates a list of PDF files currently present in the same folder.
ls -v *.pdf > pdf_list

# Loops over the list of PDF files in same directory and extracts text from it.
while read line;
do
    pdftk $line dump_data_fields > $line.txt
    grep -w 'FieldValue' $line.txt | cut -d\  -f2- | tr '\n' ',' | sed 's/.$//' >> output
    echo "" >>output
done<pdf_list
