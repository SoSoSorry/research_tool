#!/usr/bin/python3

##speration the file name, suffix and directory
def file_name_handle(file_name):
    print ("the original file name: {0}".format(file_name))
    import os
    ## tuple
    dir_file = os.path.split(file_name)
    ## list
    file_suffix = dir_file[1].split('.', 1)
    #print (type(file_suffix))
    print (dir_file[0])
    file_suffix.append(dir_file[0])
    print (file_suffix)
    return file_suffix

    
## file_extract
def file_exact(file_name, key_words):
    import re
    import os
    tmp_result = file_name_handle(file_name)
    
    if (tmp_result[2]):
        my_file = tmp_result[2] + "/" + "ext"
        if not os.path.exists(my_file):
            os.mkdir(tmp_result[2] + "/" + "ext")
        write_file = tmp_result[2] + "/" + "ext/" +tmp_result[0] + '_EXT.' + tmp_result[1]
    else:
        my_file = "./ext/"
        if not os.path.exists(my_file):
            os.mkdir("./ext/")
        write_file = "./ext/" + tmp_result[0] + '_EXT.' + tmp_result[1]
    print ("the result file: {0}".format(write_file))
    file_w = open(write_file, 'wt')
    with open(file_name, 'rt') as f:
        for line in f:
            for key in key_words:
                if ( re.search(key, line) ):
                    file_w.write(line)
                    if (key == key_words[len(key_words)-1]):
                        file_w.write('\n')
                    break

import sys
if __name__=="__main__":
    #latency
    #key_words = ['msg_size:', 'Summary:']
    #throughput
    key_words = ['msg_size:', 'Summary:', 'connection', 'core', 'Gbits/sec', 'Mbits/sec', 'Kbits/sec', 'qps', '90%', '99%']
    file_exact(sys.argv[1], key_words)
