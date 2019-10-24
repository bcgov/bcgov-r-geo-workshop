---
title: Setting Up Git
teaching: 5
exercises: 0
questions:
- "How do I get set up to use Git?"
objectives:
- "Configure `git` the first time it is used on a computer."
- "Understand the meaning of the `--global` configuration flag."
keypoints:
-   "Use `git config` with the `--global` option to configure a user name, email address, editor, and other preferences once per machine."
---

#### Git Set Up

When we use Git on a new computer for the first time,
we need to configure a few things. Below are a few examples
of configurations we will set as we get started with Git:

*   our name and email address,
*   what our preferred text editor is,
*   and that we want to use these settings globally (i.e. for every project).

On a command line, Git commands are written as `git verb options`,
where `verb` is what we actually want to do and `options` is additional optional information which may be needed for the `verb`. 


#### Set user.name & user.email

So here is how
Dracula sets up his new laptop:

~~~
$ git config --global user.name "Vlad Dracula"
$ git config --global user.email "vlad@tran.sylvan.ia"
~~~


Please use your own name and email address instead of Dracula's. This user name and email will be associated with your subsequent Git activity, which means that any changes pushed to a remote on
[GitHub](https://github.com/),
[BitBucket](https://bitbucket.org/),
[GitLab](https://gitlab.com/) or
another Git host server will include this information.

For these lessons, we will be interacting with [GitHub](https://github.com/) and so the email address used should be the same as the one used when setting up your GitHub account. 

If you are concerned about privacy, please review [GitHub's instructions for keeping your email address private][git-privacy]. 


#### Set Favourite Text Editor

Dracula also has to set his favorite text editor, following this table:

| Editor             | Configuration command                            |
|:-------------------|:-------------------------------------------------|
| Atom | `$ git config --global core.editor "atom --wait"`|
| nano               | `$ git config --global core.editor "nano -w"`    |
| BBEdit (Mac, with command line tools) | `$ git config --global core.editor "bbedit -w"`    |
| Sublime Text (Mac) | `$ git config --global core.editor "/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -n -w"` |
| Sublime Text (Win, 32-bit install) | `$ git config --global core.editor "'c:/program files (x86)/sublime text 3/sublime_text.exe' -w"` |
| Sublime Text (Win, 64-bit install) | `$ git config --global core.editor "'c:/program files/sublime text 3/sublime_text.exe' -w"` |
| Notepad++ (Win, 32-bit install)    | `$ git config --global core.editor "'c:/program files (x86)/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"`|
| Notepad++ (Win, 64-bit install)    | `$ git config --global core.editor "'c:/program files/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin"`|
| Kate (Linux)       | `$ git config --global core.editor "kate"`       |
| Gedit (Linux)      | `$ git config --global core.editor "gedit --wait --new-window"`   |
| Scratch (Linux)       | `$ git config --global core.editor "scratch-text-editor"`  |
| Emacs              | `$ git config --global core.editor "emacs"`   |
| Vim                | `$ git config --global core.editor "vim"`   |
| VS Code                | `$ git config --global core.editor "code --wait"`   |

It is possible to reconfigure the text editor for Git whenever you want to change it.


#### Global Settings

The three commands we just ran above only need to be run once: the flag `--global` tells Git
to use the settings for every project, in your user account, on this computer.

You can check your settings at any time:

~~~
$ git config --list
~~~


You can change your configuration as many times as you want: use the
same commands to choose another editor or update your email address.



#### Exiting Vim

Note that Vim is the default editor for many programs. If you haven't used Vim before and wish to exit a session without saving
your changes, press <kbd>Esc</kbd> then type `:q!` and hit <kbd>Return</kbd>.
If you want to save your changes and quit, press <kbd>Esc</kbd> then type `:wq` and hit <kbd>Return</kbd>.


#### Git Help and Manual

Always remember that if you forget a `git` command, you can access the list of commands by using `-h` and access the Git manual by using `--help` :

~~~
$ git config -h
$ git config --help
~~~

While viewing the manual, remember the `:` is a prompt waiting for commands and you can press <kbd>Q</kbd> to exit the manual.


[git-privacy]: https://help.github.com/articles/keeping-your-email-address-private/
