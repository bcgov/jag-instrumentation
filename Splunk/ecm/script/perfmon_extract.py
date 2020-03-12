#Tested on python 3.7
#reference  - https://stackoverflow.com/questions/14894993/running-windows-shell-commands-with-python
# created by Ranti Familusi ranti.familusi@nttdata.com

import subprocess

#remove duplicates
def remove_duplicates(duplicates):
    return list(dict.fromkeys(duplicates))

# extract performance monitors enabled on a server
def extract_perfmon (interval):
    content = ""
    result = []
    duplicated_objects = []
    win_cmd = 'typeperf -q'
    process = subprocess.Popen(win_cmd,
    shell=True,
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE )
    for line in process.stdout:
        result.append(line.decode("utf-8"))
    for line_a in result:
        counters_and_objects = line_a[1:].split('\\')
        
        if (len(counters_and_objects) > 1):
            items = (counters_and_objects[0].replace('(*)',''))
            duplicated_objects.append(items)       
    non_duplicated_objects = remove_duplicates(duplicated_objects)
    for single_object in non_duplicated_objects:
        lines = ['[perfmon://'+single_object+']','object = '+single_object,'counters = *','instances = *', "disabled = 0",'interval = '+ str(interval),'\n']
        content += '\n'.join(lines)
    return content

#create conf file. Conf file should be put in $SPLUNK_HOME\etc\system\local
def create_file(content):
    f = open("input.conf","w+")
    f.write(content)

# interval can be passed as parameter
create_file(extract_perfmon(60))
