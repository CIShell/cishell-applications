#!/usr/bin/env python 

from sys import argv
from gzip import open as gzopen
from airports import *
from transitions import *

def main():
    
    value = argv[1]

    cities = Airports(argv[2])

    files = [0 for i in xrange(17)]

    hemispheres = [0 for i in xrange(17)]

    for line in open(argv[3]):
        fields = line.strip().split()

        index = int(fields[0])
        hemi = int(fields[1])
        name = fields[2]

        hemispheres[index] = hemi
        files[index] = open("pop." + name + "." + value + ".dat", "w")

    data = [[] for i in xrange(len(files))]

    for file in argv[4:]:

        states = {}

        time = 0

        for line in gzopen(file):
            line = line.strip()
            
            if len(line) == 0:
                continue

            if line[0] == "#" and line[2:6] == "time":
                fields = line.split()

                for id in xrange(2,len(fields)):
                    states[fields[id]] = id
                    for i in xrange(len(files)):
                        files[i].write("@    s"+str(id-2)+" legend  \""+fields[id]+"\"\n")

                continue

            if line[0] == "#":
                continue

            fields = line.split()

            if fields[1] != time:
                for region in xrange(len(files)):
                    temp = []
                    total = 0

                    temp.append(str(time))

                    for i in xrange(len(data[region])):
                        temp.append(str(data[region][i]))
                        total += data[region][i]

                    if total!=0:
                        temp.append(str(total))
                
                        files[region].write(" ".join(temp)+"\n")

                for region in xrange(len(files)):
                    data[region] = [0 for i in xrange(len(states))]


            time = fields[1]
            city = fields[0]
            region = int(cities.data[cities.codes[city]].region)
            
            if int(cities.data[cities.codes[city]].hemisphere) ==  hemispheres[region]:
                for i in xrange(2,len(fields)):
                    data[region][i-2] += int(fields[i])

           

if __name__ == "__main__":
    main()