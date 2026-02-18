# Bash Input Concepts: `read`, `IFS` & Here Strings (`<<<`)

## `read` — Read Input Line by Line

`read` is a Bash builtin that reads **one line** of input and stores it in a variable.

```bash
# Basic usage
echo "Hello World" | read -r word
# word = "Hello World" (entire line, not just one word)
```

### Common Flags

| Flag | Meaning | Example |
|------|---------|---------|
| `-r` | **Raw** — don't treat `\` as escape | `read -r path` (always use this!) |
| `-p` | **Prompt** — show a message | `read -rp "Name: " name` |
| `-s` | **Silent** — hide input (passwords) | `read -rs password` |
| `-t N` | **Timeout** — wait N seconds | `read -rt 5 answer` |
| `-n N` | Read only **N characters** | `read -rn 1 key` |

### Without `-r` vs With `-r`

```bash
echo "C:\new\folder" | read word      # word = "C:ew\folder" ❌ (\n became newline)
echo "C:\new\folder" | read -r word   # word = "C:\new\folder" ✅ (preserved)
```

> **Rule:** Always use `read -r`. There's almost never a reason not to.

### Multiple Variables

```bash
echo "John 25 India" | read -r name age country
# name="John"  age="25"  country="India"

echo "one two three four" | read -r first rest
# first="one"  rest="two three four" (last variable gets the remainder)
```

---

## `IFS` — Internal Field Separator

`IFS` tells Bash **how to split text** into parts. By default, IFS is set to **space, tab, and newline**.

### Default Behavior (Strips Whitespace)

```bash
echo "  Hello World  " | read -r greeting
# greeting = "Hello World" (leading/trailing spaces stripped!)
```

### `IFS=` (Empty) — Preserve Everything

```bash
echo "  Hello World  " | IFS= read -r greeting
# greeting = "  Hello World  " (spaces preserved!)
```

### Custom IFS — Split on Any Character

```bash
# Split on colon (:)
IFS=':' read -r user pass uid <<< "root:x:0"
# user="root"  pass="x"  uid="0"

# Split a PATH variable
IFS=':' read -ra paths <<< "$PATH"
# paths is an array of all PATH directories
# -a flag reads into an array
```

### IFS Scope — Set It Temporarily

```bash
# Only affects this one read command (doesn't change global IFS)
IFS=':' read -r user pass <<< "root:x"

# VS setting it globally (avoid this)
IFS=':'          # now ALL string splitting in the script uses ':'
read -r user pass <<< "root:x"
```

> **Best practice:** Always set `IFS` on the **same line** as `read` to keep it temporary.

---

## `<<<` — Here String

The `<<<` operator feeds a **string/variable as input** to a command. Think of it as: *"Here, use this as your input."*

### Basic Syntax

```bash
command <<< "string"
command <<< "$variable"
```

### Examples

```bash
# Count words in a string
wc -w <<< "one two three"
# Output: 3

# Feed a variable to read
name="Paarth"
read -r greeting <<< "$name"
echo "$greeting"   # Paarth

# Feed to grep
grep "error" <<< "no error found here"
# Output: no error found here

# Convert to uppercase
tr '[:lower:]' '[:upper:]' <<< "hello"
# Output: HELLO
```

### `<<<` vs Pipe (`|`)

```bash
# Using pipe — creates a SUBSHELL (variable changes are LOST!)
echo "$data" | while read -r line; do
    count=$((count + 1))   # this count is lost after the loop!
done
echo "$count"   # still 0! 😢

# Using <<< — stays in SAME shell (variable changes are KEPT!)
while read -r line; do
    count=$((count + 1))   # this count persists!
done <<< "$data"
echo "$count"   # correct value! 🎉
```

> **Rule:** Prefer `<<<` over `echo "..." | command` when possible.

---

## Combining All Three: The `while read` Pattern

The most common real-world usage of all three concepts together:

```bash
# Process a multi-line variable, line by line
data="Chrome
Brave
Zen Browser"

while IFS= read -r line; do
    printf "Processing: %s\n" "$line"
done <<< "$data"
```

### How It Flows

```
$data is fed via <<<  →  read grabs line 1  →  loop body runs
                      →  read grabs line 2  →  loop body runs
                      →  read grabs line 3  →  loop body runs
                      →  read finds nothing →  loop ENDS
```

### Real-World Example: Processing User Selections

```bash
selected=$(gum choose --no-limit 'Option A' 'Option B' 'Option C')

while IFS= read -r choice; do
    case "$choice" in
        "Option A") do_something_a ;;
        "Option B") do_something_b ;;
        "Option C") do_something_c ;;
    esac
done <<< "$selected"
```

### Processing a File Line by Line

```bash
while IFS= read -r line; do
    printf "Line: %s\n" "$line"
done < "/etc/os-release"     # note: < not <<< (reads from a FILE)
```

| Operator | Reads From |
|----------|-----------|
| `<<<` | A **string/variable** |
| `<` | A **file** |
| `\|` | A **command's output** (creates subshell) |

---

## Quick Reference

```bash
# Read one line from user
read -rp "Enter name: " name

# Read line by line from a variable
while IFS= read -r line; do
    echo "$line"
done <<< "$variable"

# Read line by line from a file
while IFS= read -r line; do
    echo "$line"
done < "filename.txt"

# Split on custom delimiter
IFS=',' read -ra items <<< "a,b,c,d"
# items=("a" "b" "c" "d")

# Read with timeout
if read -rt 5 -rp "Quick! Enter something: " answer; then
    echo "You said: $answer"
else
    echo "Too slow!"
fi
```

---

## Printf Format Specifiers (Bonus)

| Specifier | Meaning | Example |
|-----------|---------|---------|
| `%s` | String | `printf "%s" "hello"` → `hello` |
| `%d` | Integer | `printf "%d" 42` → `42` |
| `%f` | Float | `printf "%f" 3.14` → `3.140000` |
| `%%` | Literal `%` | `printf "100%%"` → `100%` |

## Default Values (Bonus)

| Syntax | Variable SET | Variable UNSET |
|--------|-------------|----------------|
| `${VAR:-default}` | Uses `$VAR` | Uses `default` |
| `${VAR:=default}` | Uses `$VAR` | Sets & uses `default` |
| `${VAR:+alt}` | Uses `alt` | Uses nothing |
| `${VAR:?error}` | Uses `$VAR` | Crashes with `error` |
