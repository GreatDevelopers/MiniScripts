import csv

CSV_FILENAME = "data.csv"
TEMPLATE_FILENAME = "letter.tmp"
HEADER_PREFIX = "__"
CURRENT_DATE = "13-04-2020"


template = ""
with open(TEMPLATE_FILENAME, "r") as template_file:
    template = template_file.read()

with open(CSV_FILENAME, "r") as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=",")
    lines = list(csv_reader)
    header_list = lines[0]
    for count, line in enumerate(lines[1:]):
        new_template = template
        for i, header in enumerate(header_list):
            replacing_str = HEADER_PREFIX + header
            new_template = new_template.replace(replacing_str, line[i])
        new_template = new_template.replace("__CurrentDate", CURRENT_DATE)

        with open("letter_" + str(count + 1) + ".txt", "w") as output_file:
            output_file.write(new_template)
