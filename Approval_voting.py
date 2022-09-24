# Name: Daven Chohan
# Student ID: 301401324
# CMPT 383 Final Project Initial Implementation in Python

ballot_file = input("What is the name of the ballot file?\n")
myFile=open(str(ballot_file),'r')
every_character = []
total_ballots = 0
num_of_none = 0

for x in myFile:
    candidates = []
    total_ballots += 1
    x = x.rstrip()
    if x != 'none':
        for i in x.split(' '):
            if i not in candidates:
                candidates.append(i)
    else:
        num_of_none += 1
    every_character.extend(candidates)
myFile.close()

candidate_list = []
for char in every_character:
    if char not in candidate_list:
        if char not in [' ', '\n']:
            candidate_list.append(char)
print("\nTotal # of ballots: " + str(total_ballots) + '\n')

candidate_length = len(candidate_list)
thisdict = {}
count = []
for x in candidate_list:
    thisdict[x] = str(every_character.count(x))
    count.append(x)
#Sorting method learned from here: https://stackoverflow.com/questions/35609991/how-do-i-print-a-sorted-dictionary-in-python-3-4-3?noredirect=1&lq=1
thisdict = sorted(thisdict.items(), key = lambda x: int(x[1]), reverse = True)

for x,y in thisdict:
    print(x + ": " + y)
print("\nempty: " + str(num_of_none))

num_of_full = 0
myFile=open(str(ballot_file),'r')
for x in myFile:
    y=x.rstrip()
    candidates = []
    if y != 'none':
        for i in y.split():
            if i not in candidates:
                candidates.append(i)
    if len(candidates) == len(candidate_list):
        num_of_full += 1
myFile.close()

print("full: " + str(num_of_full))


##    How to run the program final_project.py on a Ubuntu Linux machine.
##
##    Pre-Reqs:
##    Make sure you have Python 3 installed, the program was tested on python version 3.7 and version 3.8.5
##
##    1. Open up terminal and navigate to the directory of where the program is saved.
##
##    2. Once in the correct directory in terminal type in "python final_project.py" (ignoring the quotation marks)
##
##    3. The program will then ask you the name of the ballot file, the ballot file must be in the same directory as the program
##       and when you enter the file name it must end in .txt (for example: "example5.txt")
##
##    4. If a proper name is entered you will now see the results.
##
##    How to run the program final_project.py on a Windows machine.
##
##    Pre-Reqs:
##    Make sure you have Python 3 installed, the program was tested on python version 3.7 and version 3.8.5
##
##    1. Open up the program using the Python IDLE and click the run button in the top tool bar.
##
##    2. From the drop down menu choose run module.
##
##    3. The program will then ask you the name of the ballot file, the ballot file must be in the same directory as the program
##       and when you enter the file name it must end in .txt (for example: "example5.txt")
##
##    4. If a proper name is entered you will now see the results.
       
    

