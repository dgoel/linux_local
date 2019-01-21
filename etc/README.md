# Overview

Configuration files (aka dotfiles) for various utilities like bash, git, vim
etc. The organization of dotfiles is motivated by [GNU
stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html),
which uses symbolic links to install a configuration so that it can be used by
the system.

# Usage

The procedure is simple. Create the `${HOME}/etc` directory and then inside it
create subdirectories for all the programs whose cofigurations you want to
manage. Inside each of those directories, move in all the appropriate files,
maintaining the directory structure of the home directory. So, if a file
normally resides at the top level of your home directory, it would go into the
top level of the program's subdirectory. For example, if a file normally goes in
the default `${XDG_CONFIG_HOME}/${PKGNAME}` location
(`${HOME}/.config/${PKGNAME}`), then it would instead go in
`${HOME}/etc/${PKGNAME}/.config/${PKGNAME`} and so on. Finally, from the etc
directory, simply run `$ stow $PKGNAME` and Stow will symlink all the package's
configuration files to the appropriate locations. It's then easy to make the etc
a VCS repository so you can keep track of changes you make (plus it makes it so
much easier to share configurations between different computers, which was my
main reason to do it).

For example, let's say you want to manage the configuration for `bash` and `vim`.
`Bash` has a couple files in the top-level directory and `vim` typically has your
`.vimrc` file on the top-level and a `.vim` directory. So, your home directory
looks like this:

```bash
    home/
        dgoel/
            .vim/
                [...some files]
            .bashrc
            .bash_profile
            .bash_logout
            .vimrc
```

You would then create a `local/etc` subdirectory and move all the files there:

```bash
    /home/
         dgoel/
            local/etc/
                bash/
                    .bashrc
                    .bash_profile
                    .bash_logout
                vim/
                    .vim/
                        [...some files]
                    .vimrc
```

Then, perform the following commands:

```bash
    $ cd ~/local/etc
    $ stow -vv -t ${HOME} bash
    $ stow -vv -t ${HOME} vim
    $ stow -vv -t ${HOME} git
    $ stow -vv -t ${HOME} terminator
    $ stow -vv -t ${HOME} tmux
```
This will create symbolic link from `local/etc` directory to the configuration files.
