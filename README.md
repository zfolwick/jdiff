# jdiff
a practical json diffing tool for quickly checking two json files for differences that the user cares about, while ignoring what's not important.

jdiff follows the patterns of previous, existing *nix diffing tools like `diff`, `zdiff`, `sdiff`, etc. and is heavily borrowed from https://github.com/jlevy/pdiffjson.

# get jdiff
The easiest way to acquire jdiff:
```bash
wget https://raw.githubusercontent.com/zfolwick/jdiff/refs/heads/main/jdiff.sh -O jdiff
chmod +x jdiff
```
anything else is just showing off.

Also, if you don't have it already, insteall `jq`. Besides being the best json formatter for the terminal, it basically powers this whole script.

# installation

On a mac:

```bash
cp ~/.local/bin/jdiff
```

On linux:
(you hardly need help if you're using linux- just put it on the PATH)

On windows:
(use linux or mac)

# use jdiff
You can put it somewhere on your PATH and it'll always be easy to use, anywhere.  The following examples assume you were untrustworthy and kept it as a shell script in a directory not on your PATH.

`jdiff --help` provides usage info.

`jdiff a.json b.json` produces a simple output.

`jdiff -u --color=always a.json b.json` emulates `git diff`

but you can pass in standard `diff` flags as well.

`jdiff -U 4 --color=always a.json b.json` produces 4 lines of context with a coloration indicating the different lines, same as `diff`.

# ignoring objects
Many times we don't care about certain objects when comparing json, such as timestamp fields, or fields containing other ephemeral data.  We can put the fields we want to ignore into a file, and pass that file in by name:

`jdiff --ignorefile=my_ignore_file a.json b.json` produces an output with the object, and any sub-objects it containts removed.

We can also combine both `diff` and `ignore`:

`jdiff -U 4 --color=always --ignorefile=my_ignore_file a.json b.json` produces the standard diffing output, while ignoring any fields indicated in the `my_ignore_file`
