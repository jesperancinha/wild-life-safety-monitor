import re

def transform_string(regex_pattern, input_string):
    def repl(m):
        if m:
            return m.group(1)
        else:
            return m.group(0)

    transformed_string = re.sub(regex_pattern, repl, input_string)
    return transformed_string

def read_file(filename):
    with open(filename, 'r') as file:
        return file.read()

filename = "script.sh"
regex_pattern = r'\-e\s+\"([A-Z_]*_[A-Z_]*=[\w\.:\-\s\/+\s\n=,]*)\"\s+'

input_string = read_file(filename)

transformed_string = transform_string(regex_pattern, input_string)

def process_file(filename, condition):
    with open(filename, 'w') as output_file:
        for line in transformed_string.strip().split("\\"):
            if condition(line):
                if("-----BEGIN" in line):
                    first, second = line.split("=",1)
                    output_file.write(first+"=\""+second+"\"")
                else:
                    output_file.write(line)

filename = ".env"

def condition(line):
    return "=" in line

process_file(filename, condition)
