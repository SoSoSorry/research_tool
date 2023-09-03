#!/usr/bin/python3

import json
import sys
import numpy as np
import matplotlib.pyplot as plt

width = 0.3
#color = ['salmon', 'steelblue',  'mediumaquamarine',  'yellowgreen', 'darkgreen', 'darkblue', 'c']
color = [ 'steelblue',  'salmon',  'mediumaquamarine','sandybrown',  'darkgreen', 'yellowgreen','darkblue', 'c']
#size
fontsize = 25
y_upper_limitation = 110

def bar_add(label_list, data, setting):
    plt.figure(figsize=(7,5))
    x = range(len(data[0]['data']))
    plt.bar(x=x, height=data[0]['data'], width=width, alpha=0.8, color=color[0%len(color)], label=data[0]['name'], edgecolor='k',zorder=2) 
    plt.bar(x=x, height=data[1]['data'], width=width, alpha=0.8, color=color[1%len(color)], label=data[1]['name'], edgecolor='k',zorder=2, bottom=np.array(data[0]['data']))
    plt.bar(x=[j+width for j in x], height=data[2]['data'], width=width, alpha=0.8, color=color[2%len(color)], label=data[2]['name'], edgecolor='k',zorder=2)
    
    plt.xticks([index+width/2 for index in x], label_list, fontsize= fontsize)
    plt.xticks(rotation=-30)
    plt.yticks(fontsize= fontsize)

    plt.xlabel(setting['xlabel'], fontsize = fontsize)
    plt.ylabel(setting['ylabel'], fontsize = fontsize)

    plt.ylim(0, setting['y_upper_limitation'])
    plt.grid(linestyle='--', linewidth = 0.5)
    print(type(sys.argv[3]))
    loc = 'upper left'
    if(len(sys.argv) > 4):
        if(sys.argv[4] == 'right'):
            loc = 'upper right'

    plt.legend(loc=loc, ncol = int(sys.argv[3]), fontsize=fontsize,frameon=False,columnspacing=1.5, labelspacing=0) #upper/center/lower/right/left
    plt.savefig(sys.argv[2], bbox_inches='tight')
    plt.show()

def bar(label_list, data, setting):

    x = range(len(data[0]['data']))
    for i in range(len(data)):
        plt.bar(x=[j+width*i for j in x], height=data[i]['data'], width=width, alpha=0.8, color=color[i%len(color)], label=data[i]['name'], edgecolor='k', zorder=2)
    
    
    plt.xticks([index + (len(data)-1)*width/2 for index in x], label_list, fontsize = fontsize-5)
    plt.yticks(fontsize = fontsize-5)

    plt.xlabel(setting['xlabel'], fontsize = fontsize)
    plt.ylabel(setting['ylabel'], fontsize = fontsize)
    #ax = plt.gca()
    #ax.spines['right'].set_color('none')
    #ax.spines['top'].set_color('none')
    #ax = plt.subplot(111)
    #ax.set_xlabel(fontsize = fontsize)
    #ax.set_ylabel(fontsize = fontsize)
    
    plt.ylim(0, setting['y_upper_limitation'])
    plt.grid(linestyle='--', linewidth = 0.5)
    print(type(sys.argv[3]))
    loc = 'upper left'
    if(len(sys.argv) > 4):
        if(sys.argv[4] == 'right'):
            loc = 'upper right'

    plt.legend(loc=loc, ncol = int(sys.argv[3]), fontsize=fontsize,columnspacing=1.5) #upper/center/lower/right/left
    plt.savefig(sys.argv[2], bbox_inches='tight')
    plt.show()



if __name__ == "__main__":
    with open(sys.argv[1], 'r') as f:
        json_data = json.load(f)
        label_list = json_data['label_list']
        data = json_data['data']

        setting = json_data['setting']
    bar_add(label_list, data, setting)
            

