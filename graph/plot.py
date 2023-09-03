#!/usr/bin/python3 
 
import json 
import sys 
import numpy as np
#import matplotlib
import matplotlib.pyplot as plt 
#from matplotlib.backends.backend_pdf import PdfPages 
#matplotlib.use('TkAgg')
def plot(label_list, data_list, setting): 
    color = ['-ro', '-bo', '-go','-.ro', '-.bo', '-.go'] 
    legend = [] 
    for index in range(len(data_list)): 
        print("index: {0}".format(index))
        x1 = label_list
        print(x1)
        y1 = data_list[index]['data']
        print(y1)
 
        plt.plot(x1,y1, color[index%len(color)], ms=5) 
        legend.append(data_list[index]['name'])

    plt.tick_params(axis='x', labelsize = 25)
    plt.tick_params(axis='y', labelsize = 25)
    plt.ylim(0, setting['y_upper_limitation'])
    print(legend)
    plt.xlabel(setting['xlabel'], fontsize = 25)
    plt.ylabel(setting['ylabel'], fontsize = 25)
    #plt.title 
    plt.legend(legend, ncol=2, loc="lower left", bbox_to_anchor=(-0.05, -0.5), columnspacing=1, fontsize=25) 
    plt.grid(linestyle='--', linewidth=0.5) 
    plt.savefig(sys.argv[2], bbox_inches='tight') 
    plt.show()


if __name__ == "__main__": 
    with open(sys.argv[1], 'r') as f: 
        json_data = json.load(f) 
        label_list = json_data['label_list']
        data_list = json_data['data']
        #data3 = json_data['data3']
        #data_list.append(data3)
        setting = json_data['setting'] 
    plot(label_list, data_list, setting) 

