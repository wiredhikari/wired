#!/usr/bin/env python
import sys
import os
import re

# Variables
args = sys.argv
pattern = None
word = ''
split = '\n'
intype = "file"

try:
    inputdata = args[len(args)-1]

except IndexError:
    print("You have to add the inputdata at the end of the command")

def find_by_word():
    with open(inputdata, 'r') as file:
        for line in file:
            if word in line:
                print(line)

for arg in args:
    if arg in ["-s", "--split"]:
        split = args[args.index(arg)+1]

    elif arg in ["-p", "--patern"]:
        pattern = args[args.index(arg)+1]
   
    elif arg in ["-l", "--line"]:
        word = args[args.index(arg)+1]

    elif arg in ["-pipe"]:
        intype = "pipe"
        inputdata = sys.stdin.read()

try:
    if __name__ == "__main__":
        if word:
            find_by_word()
        
        elif intype == "pipe":
            result = re.findall(pattern, inputdata)
            for word in result:
                print(word, end=f'{split}')

        elif pattern:
            with open(inputdata, 'r') as file:
                
                result = re.findall(pattern, file.read())
                for word in result:
                    print(word, end=f'{split}')
                
        else:
            print("Remember that you need to specify a pattern either with '-p' or '--patern' or you can search by word with '-l' or '--line'")
        
except Exception as e:
    print("That file may not exist or there is an internal error")
    print(type(e).__name__, e)
    exit()
