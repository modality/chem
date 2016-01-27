# chem

Repeating yourself on the command line, but not enough to write a shell script?

**`chem` can help.**

```
$ chem help
NAME
    chem - chem is a tool for list manipulation and shell automation

SYNOPSIS
    chem [global options] command [command options] [arguments...]

VERSION
    1.0.0

GLOBAL OPTIONS
    --help        - Show this message
    --verbose, -V - Display verbose output
    --version     - Display the program version

COMMANDS
    drop   - Delete a collection
    edit   - Edit a collection in vi
    exec   - Execute a command or set of commands with substitution (use quotes)
    help   - Shows a list of commands or help for one command
    in     - Create or modify a collection with data from stdin
    init   - Create an empty .chemrc file
    list   - List all collections
    new    - Create an empty collection
    out    - Show the contents of a collection
    rename - Rename a collection
    run    - Execute a collection as a list of commands with substitution
    run1   - Execute a single command from a collection with substitution
    runN   - Execute a collection's Nth set of commands with substitution
```

## Installation
`chem` is written in Ruby.

```
git clone git@github.com:modality/chem.git
cd chem
bundle install vendor/bundle
rake install
```

## Create a workspace: `init`
Create a new `.chemrc` file in the current directory to use `chem`.

```
$ chem init
Initialized empty .chemrc file at ~/.chemrc
```

## Piping: `in` and `out`
Pipe to and from `chem`.
```
$ echo -e "12\n23\n34" | chem in foo
Added new collection "foo"

$ chem out foo
12
23
34

$ chem out foo | grep 2
12
23
```

## Execution: `exec`, `run`, `run1`, and `runN`
Now for some advanced substitution techniques. These commands execute
in the context of the current `.chemrc` file. Text with angle brackets
will be replaced with values from that collection.

Let's set up some test data to play with.
```
$ echo -e "chem\ngem\ngarbage" | chem in vals && chem out vals
Added new collection "vals"
chem
gem
garbage

$ echo -e "echo \"filenames containing <vals>\"\n\
ls -al | grep -i <vals>" | chem in val_user
Added new collection "val_user"

$ chem out val_user
echo "filenames containing <vals>"
ls -al | grep -i <vals>
```

`exec` - Execute commands from the command line
```
$ chem exec "echo 0 <vals>" "echo 1 <vals>"
0 chem
1 chem
0 gem
1 gem
0 garbage
1 garbage
```

`run` - Execute a collection
```
$ chem run val_user
filenames containing chem
-rw-r--r--   1 michaelhansen  staff   743 Jan 25 20:06 .chemrc
-rw-r--r--   1 michaelhansen  staff   713 Jan 25 19:31 chem.gemspec
filenames containing gem
-rw-r--r--   1 michaelhansen  staff    38 Jan  9 08:35 Gemfile
-rw-r--r--   1 michaelhansen  staff  1074 Jan 24 15:29 Gemfile.lock
-rw-r--r--   1 michaelhansen  staff   713 Jan 25 19:31 chem.gemspec
filenames containing garbage
```

`run1` - Execute a single line in a collection as a command
```
$ chem -V out val_user
id | value
0  | echo "filenames containing <vals>"
1  | ls -al | grep -i <vals>

$ chem run1 val_user 0
filenames containing chem
filenames containing gem
filenames containing garbage
```

`runN` - Execute a collection of commands, using the Nth substitution
```
$ chem -V out vals
id | value
0  | chem
1  | gem
2  | garbage

$ chem runN val_user 1
filenames containing gem
-rw-r--r--   1 michaelhansen  staff    38 Jan  9 08:35 Gemfile
-rw-r--r--   1 michaelhansen  staff  1074 Jan 24 15:29 Gemfile.lock
-rw-r--r--   1 michaelhansen  staff   713 Jan 25 19:31 chem.gemspec
```
