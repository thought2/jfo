# jfo
JSON Based Commandline Tool To Create Folder Structures Containing Textfiles

this tool is meant to be a helper in creating folder structures declaratively. On the commandline we often end up in `mkdir`, `cd`, `touch` and `echo` sessions. And jfo is a simple toot to make this process less imperative.

For instance instead of using the following commands...

```
mkdir -p dir1/subdir1
echo "Hello from file one!" > dir1/subdir1/file1.txt
echo "Hello from file two!" > dir1/subdir1/file2.txt
mkdir -p dir2/subdir2
mkdir -p dir
```

one can just write this JSON file...

```
structure.json

{
  "dir1": {
    "subdir1": {
      "file1.txt": "Hello from file one!",
      "file2.txt": "Hello from file two!"
    },
    "subdir2": {}
  },
  "dir2": {}
}
```

and pass it to `jfo` along with the destination/base directory, in which the structure should be realized.

For instance `jfo structure.json /tmp` would realize the above structure in the `/tmp` directory.
