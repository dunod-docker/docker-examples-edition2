import os
import sys
import os.path

def load_properties(filepath, sep='=', comment_char='#'):
    """
    Load the properties into a dictionary
    """
    props = {}
    with open(filepath, "rt") as f:
        for line in f:
            l = line.strip()
            if l and not l.startswith(comment_char):
                key_value = l.split(sep)
                key = key_value[0].strip()
                value = sep.join(key_value[1:]).strip().strip('"') 
                props[key] = value 
    return props

def replace_string(line, props):
    """
    Replace the properties in the specified string using the dictionary
    """
    newline = line
    for key in props:
        replaced = newline.replace("${"+key+"}",props[key])
        if newline != replaced:
            print "\tReplacing ${"+key+"}"
        newline = replaced
    return newline

def replace_file(filepath,props):
    """
    Replace the properties in the specified file using the dictionary
    """
    with open(filepath+".tmp", "w") as fw:
        with open(filepath, "r") as fr:
            for line in fr:
                fw.write(replace_string(line,props))
    os.remove(filepath)     
    os.rename(filepath+".tmp",filepath)


if len(sys.argv)!=3:
    print "Wrong number of arguments !"
    print "Usage : python replacer.py <<properties file>> <<file to replace>>"
    exit(1)

properties_file_path=sys.argv[1]
file_to_replace_path=sys.argv[2]

if not os.path.isfile(properties_file_path):
    print "The path {} does not exists".format(properties_file_path)
    exit(1)

if not os.path.isfile(file_to_replace_path):
    print "The path {} does not exists".format(file_to_replace_path)
    exit(1)

print "Replacing {}".format(file_to_replace_path)
props=load_properties(properties_file_path)
replace_file(file_to_replace_path,props)