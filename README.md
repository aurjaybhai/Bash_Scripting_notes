# Bash_Scripting_notes

##### Current Shell

```bash
echo $0
```

##### How to add Multi Line Comment

```bash
<< comment
-----------
-----------
comment
```

##### Variables

- *var_name = value*
- *var_Name* = *$(hostname)*

##### Constant Variable

```bash
readonly var_name = "Hi"
```

##### Arrays

```bash
myArray=(1 20 Hello "Hey Buddy!")
```

##### Get Values from an array

```bash
echo "${myArray[0]}"
```

```bash
echo "${myArray[1]}"
```

##### If you want to print everything at ones then

```bash
echo "${#myArray[*]}"
```

##### How to get specific Values

```bash
echo "${myArray[*]:1}"
```

```bash
echo "${myArray[*]:1:2}"
```

##### Update an Array

```bash
myArray+=( 5 6 8)
```

##### Array key-value

***First you need declare this line in the bash script***

```bash
declare -A myArray
```

```bash
myArray=([name]=Paul [age]=20)
```

*Call the variables from this array*

```bash
echo "${myArray[name]}"
```

##### String Operations

```bash
myVar="Hello World!"
```

```bash
length=${#myVar}
```

```bash
upper=${myVar^^}
```

```bash
lower=${myVar,,}
```

```bash
replace=${myVar/old_Word/newWord}
```

```bash
slice=${myVar:6:11}
```

<center>Kitne length chaye which is 11</center>

##### User Interaction

```bash
read -p "Your Name" NAME
```

- **NAME** is ***variable name*** given in this command
- **Your name** is the *message*

##### Arithmetic Operations

```bash
let mul=$x*$y
```

```bash
echo "$mul"
```

***Examples 2***

```bash
let sum=$x+$y
```

```bash
echo "$sum"
```

##### Another Method

```bash
echo "Subraction is $(($x-$y))"
```

#### Conditional Statements
### Operators

| Greater than or equal to | `-ge`      |
| ------------------------ | ---------- |
| Less than or equal to    | `-le`      |
| Not Equal                | `-ne`/`!=` |
| Greater than             | `-gt`      |
| Less than                | `-lt`      |
### ELIF

```bash
if [[ $marks -ge 80 ]]; then
	echo "First Division"
elif [[ $marks -ge 60 ]]; then
	echo "Second Division"
else
	echo "FAIL"
fi
```

### CASE

```bash
echo "Hey choose an option"
echo "a = To see the current date"
echo "b = List all the files in current directory"
read choice
case $choice in
	a)date;;
	b)ls;;
	*) echo "Non valid input"
esac
```

### Logical Operators

***Condition 1***  && ***Condition 2***

- **If both are conditions are true then true else false**

***Condition 1***  | | ***Condition 2***

- **If any of the condition is true then true**

### LOOP

```bash
for i in 1 2 3 4 5 6
do
	echo "Number is $i"
done
```

```bash
for name in Raju Sham Baburao
do
	echo "$name"
done
```

```bash
for p in {1..20}
do
	echo "$p"
done
```

- **This Print all the values from the loop**
### Iterate Values from file

```bash
items="/home/user/file.txt"
for item in $(cat $items)
do
	echo $item
done
```

### WHILE LOOP

***Jab tak condition true rahega tab tak while loop chalta rahega***

```bash
count=0
num=10
while [ $count -le $num ]
do
	echo "Numbers are $count"
	let count++
done
```

### FOR LOOP

```bash
myArray=(1 2 3 Hello Hi)

length=${#myArray[*]}
for (( i=0;i<$length;i++))
do
	echo "Value of array is ${myArray[$i]}"
done
```

### UNTIL LOOP

***It's opposite of while loop means*** - *jab tak condition false rahega tab tak until loop chalta rahega*

```bash
a=10

until [[ $a -eq 1 ]]
do
	echo "Value of a is $a"
	let a--
done
```

### Infinite Loop

```bash
while true
do
	echo "Hi"
	sleep 2s
done
```

### To Read Content From a File

```bash
while read myVar
do
	echo $myVar
done < file_name
```

### To Read content from a CSV File

```bash
cat myfile.csv | awk NR!=1
```

### FUNCTIONS

##### Method 1

```bash
function myfun {
	echo "Hello World"
}
```

##### Method 2

```bash
myfun(){
	echo "Hello world"
}
```

#### To call the function

```bash
myfun
```

#### How to use Arguments in Functions

```bash
addition() {
local num1=$1
local num2=$2
let sum=$num1+$num2
echo "Sum of $num1 & num2 is $sum"
}

addition 5 10
```

### Argument Passing

*How to access these arguments inside our script?*

- **To get no of arguments :-** `$#`
- **To display all arguments:- `$@`**
-  **To use or display an argument:- `$1` , `$2` , `$3`,`$4` 

##### Run the Script with argument

```bash
./myscript.sh arg1 arg2
```

####  Argument in script

***Get into more detail into this topic***

```bash
for arg in $@
do
	echo "Argument is $arg"
done
```

#### Shifting Arguments

***When we pass multiple arguments we can shift***

```bash
# To create a user, provide username and description
echo "Creating User"
echo "Username is $1"
shift
echo "Description is $@"
```

#### Create Useful Concepts

```bash
break
```

```bash
continue
```

```bash
sleep
```

```bash
exit
```

- *exit status "1"*  ==> *last command was not successful*
- *check with cmd "$?"*

# Bash Variables

```bash
$RANDOM
```

***A random integer between 0 and 32767 is generated***

```bash
$UID
```

***A User ID of the user logged in***

***Root User always has zero(0) UID***

## 📁 Path Operations

### Get Filename from Path
```bash
basename /home/hello/myscripts/test.csv
```
**Output:** `test.csv`

### Get Directory from Path
```bash
dirname /home/hello/myscripts/test.csv
```
**Output:** `/home/hello/myscripts`

### Get Absolute Path
```bash
realpath test.csv
```
**Output:** `/home/hello/myscripts/test.csv`

---

## ✅ Check if File/Directory Exists

### Directory Checks
```bash
# Check if directory exists
if [ -d folder_name ]; then
    echo "Directory exists"
fi

# Check if directory does NOT exist
if [ ! -d folder_name ]; then
    echo "Directory does not exist"
fi
```

### File Checks
```bash
# Check if file exists
if [ -f file_name ]; then
    echo "File exists"
fi

# Check if file does NOT exist
if [ ! -f file_name ]; then
    echo "File does not exist"
fi
```

---

## 🔇 Suppress Command Output

Redirect output to `/dev/null` to hide command output:

```bash
cd /root &> /dev/null
```

This redirects both stdout and stderr to null (no output displayed or saved).

---

## 📝 Script Information

### Print Script Name
```bash
echo "The name of the script is: ${0}"
```

---

## 📊 Logging

### Using Logger
Maintain logs for your scripts using the `logger` command:

```bash
logger "Hey Buddy"
```

**Log Location:** `/var/log/messages`

---

## 🐛 Debugging Scripts

### Enable Debug Mode
Add this to your script to see each command as it executes:

```bash
set -x
```

### Exit on Error
Exit script immediately if any command fails:

```bash
set -e
```

---

## 🔄 Running Scripts in Background

### Run with nohup
```bash
nohup ./script.sh &
```

- Script runs in background even after logout
- Output saved to `nohup.out` by default

---

## ⏰ Automating Scripts

### Using `at` Command
Schedule one-time job:

```bash
at 12:09 PM
    <your_command>
# Press Ctrl + D to save
```

**Check scheduled jobs:**
```bash
atq
```

**Remove scheduled job:**
```bash
atrm <id>
```

---

## 📅 Using Crontab

### View Existing Jobs
```bash
crontab -l
```

### Add New Cron Job
```bash
crontab -e
```

### Crontab Syntax
```
* * * * * command_to_execute
│ │ │ │ │
│ │ │ │ └─── Day of week (0-7, Sunday = 0 or 7)
│ │ │ └───── Month (1-12)
│ │ └─────── Day of month (1-31)
│ └───────── Hour (0-23)
└─────────── Minute (0-59)
```

### Examples

**Run script every Sunday:**
```bash
0 0 * * 0 cd /home/hello/scripts && ./script.sh
```

**Run at 3:16 AM daily:**
```bash
16 03 * * * cd /home/hello/myscript && ./script.sh
```

### 🌐 Crontab Helper
Visit [crontab.guru](https://crontab.guru/) for easy crontab expression generation!

---

## 💡 Quick Tips

- Always use absolute paths in cron jobs
- Test scripts manually before automating
- Use `set -e` and `set -x` for safer scripts
- Check logs regularly when using `logger`
- Background processes with `nohup` survive terminal closure

---
**stdout**
- Normal outut from commands
- Successful results and regular messages
**stderr**
  - Error messages and warnings
  - Diagnostic information

##### Redirection Examples
```bash
# Redirect only stdout to a file
command > output.txt

# Redirect only stderr to a file
command 2> errors.txt

# Redirect both stdout and stderr to the same file
command &> all_output.txt
# or
command > all_output.txt 2>&1

# Redirect stdout to file, stderr to /dev/null (hide errors)
command > output.txt 2> /dev/null

# Redirect stderr to /dev/null (hide errors, show normal output)
command 2> /dev/null
```
