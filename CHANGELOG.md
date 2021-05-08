
## Changelog

> all notable changes to this project get documented here in reverse chronological order per version


### [Unreleased]

> :empty

---

### v0.1.1 | 2021-May-09

* `Vasuki.FileSystem.DirWalk.ls/1` updated to handle a path string or list of paths

---

### v0.1.0 | 2021-May-08

* `Vasuki.FileSystem.DirWalk.ls/1` to enqueue a dir path, returned with first file from its list

* `Vasuki.FileSystem.DirWalk.next/0` keeps pulling file paths one at a time until current dir list gets empty, then pull another from the recursive queue

* `Vasuki.FileSystem.DirWalk.reset/0` simply cleans up any dir and file queue there is to be walked

* `Vasuki.Data.Mucket.get/1` pull the data mapped to passed bucket name and returns it

* `Vasuki.Data.Mucket.update/2` overwrites the current data mapped to passed bucket name with passed data; if new bucket then just pushes new data

* `Vasuki.Data.Mucket.reset/0` simply cleans up all state there is, all buckets are cleaned

---
