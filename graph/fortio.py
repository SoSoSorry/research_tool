#!/usr/bin/python3

import json
import sys
import numpy as np
import matplotlib.pyplot as plt

def data_generate(org_data):
    start = []
    end = []
    percent = []
    count = []
    time = []
    for i in range(len(org_data)):
        start.append(org_data[i]["Start"])
        end.append(org_data[i]["End"])
        percent.append(org_data[i]["Percent"])
        count.append(org_data[i]["Count"])
        tmp = []
        tmp.append(start[i])
        tmp = tmp * count[i]
        time = time + tmp

    #print(time)
    section = start
    section.append(end[len(end)-1])
    return {'section':section, 'time':time, 'end':end, 'percent': percent}

def json_handle(fileName):
    with open(fileName, 'r') as f:
        print(type(f))
        json_data = json.load(f)
        
        data1 = json_data['DurationHistogram']['Data']
        result1 = data_generate(data1) 
        fig,ax1 = plt.subplots()

        ax1.set_xlabel('latency / sec', fontsize=20)
        ax1.set_ylabel('respond count', fontsize=20)
        ax1.tick_params(axis="x", labelsize=15)
        ax1.tick_params(axis="y", labelsize=15)
        ax1.set_ylim(0,int(sys.argv[3]))

        ax2 = ax1.twinx()
        ax2.set_ylabel('%', fontsize=20)
        ax2.tick_params(axis="y", labelsize=15)
        ax2.set_ylim(0,int(sys.argv[4]))


        #histogram
        ax1.hist(result1['time'], result1['section'], label='successful')
        #plot
        ax2.plot(result1['end'], result1['percent'], color = 'y', label='cumulative %')
        
        data2 = json_data['ErrorsDurationHistogram']['Data']
        result2 = data_generate(data2)
        ax1.hist(result2['time'], result2['section'], label='unsuccessful  ')
        
        #ax1.legend(loc=5)
        #ax2.legend(loc=5, bbox_to_anchor=(1,0.6))
        
         
        ax1.legend(loc="upper left", fontsize=15)
        ax2.legend(loc="upper right", fontsize=15)
        #plt.ylim(0,) 
        plt.grid(linestyle='--', linewidth = 0.5) 
        #plt.legend(loc='upper right') #upper/center/lower/right/left 
        plt.savefig(sys.argv[2], bbox_inches='tight') 

        plt.show()
        #print(type(start))
        #print(start)
        #print(end)

if __name__=="__main__":
    json_handle(sys.argv[1])
