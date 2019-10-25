---
title: Creating a Repository
teaching: 10
exercises: 0
questions:
- "Where does Git store information?"
objectives:
- "Create a local Git repository."
keypoints:
- "`git init` initializes a repository."
- "Git stores all of its repository data in the `.git` directory."
---

#### Make a Git Repository

Once Git is configured, we can start using it.

We will work with a the story where Dracula is working with Wolfman investigating if it is possible to send a planetary lander to Mars. 

First, let's create a directory in `Desktop` folder for our work and then move into that directory:

~~~
$ cd ~/Desktop
$ mkdir planets
$ cd planets
~~~


Then we tell Git to make `planets` a [repository]({{ page.root }}{% link reference.md %}#repository)—a place where Git can store versions of our files:

~~~
$ git init
~~~


It is important to note that `git init` will create a repository that
includes subdirectories and their files---there is no need to create
separate repositories nested within the `planets` repository, whether
subdirectories are present from the beginning or added later. Also, note
that the creation of the `planets` directory and its initialization as a
repository are completely separate processes.

If we use `ls` to show the directory's contents,
it appears that nothing has changed:

~~~
$ ls
~~~


But if we add the `-a` flag to show everything,
we can see that Git has created a hidden directory within `planets` called `.git`:

~~~
$ ls -a
~~~


~~~
.	..	.git
~~~

Git uses this special sub-directory to store all the information about the project, 
including all files and sub-directories located within the project's directory.
If we ever delete the `.git` sub-directory,
we will lose the project's history.

We can check that everything is set up correctly
by asking Git to tell us the status of our project:

~~~
$ git status
~~~

~~~
On branch master

Initial commit

nothing to commit (create/copy files and use "git add" to track)
~~~


If you are using a different version of `git`, the exact
wording of the output might be slightly different.

#### Removing Git 

Wolfman explains to Dracula that this project folder sdid not need to be udner version control.

Solution -- USE WITH CAUTION!

Git keeps all of its files in the `.git` directory.
To recover from this little mistake, Dracula can just remove the `.git`
folder in the moons subdirectory by running the following command from inside the `planets` directory:

~~~
$ rm -rf moons/.git
~~~

But be careful! Running this command will remove
the entire Git history of a project you might want to keep. Therefore, always check your current directory using the command `pwd`.

