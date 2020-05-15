# dotfiles

## Setting up the version control of dotfiles

```bash
$ mkdir $HOME/.dotfiles
$ git init --bare $HOME/.dotfiles
$ alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ dotfiles config --local status.showUntrackedFiles no

$ echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc

$ dotfiles add .bashrc
$ dotfiles commit -m "Add .bashrc"
$ dotfiles push
```

## Setting up a new computer

```bach
$ git clone --separate-git-dir=$HOME/.dotfiles https://github.com/norbertszivos/dotfiles.git tmpdotfiles
$ rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
$ rm -r tmpdotfiles
```

### bash-git-prompt

```bash
$ sudo apt install fonts-powerline

$ git clone -b new_theme_black_or_white https://github.com/norbertszivos/bash-git-prompt.git  ~/.bash-git-prompt --depth=1
```

The other configs for *bash-git-prompt* already in the `.bashrc` file.

### ssh

If `.ssh` folder is not exist, then create a new folder.

```bash
$ mkdir .ssh
$ chmod 700 .ssh
```

Copy `id_rsa` files to the `.ssh` folder.

```bash
$ cp id_rsa* ~/.ssh
$ chmod 600 ~/.ssh/id_rsa*
$ ssh-add
```

### git

```bash
$ sudo apt install git
```

Add user info to `.gitconfig`

### gpg

Find private key.

```bash
$ gpg --list-secret-keys user@example.com

sec   rsa4096 2020-01-01 [SC]
      ABCD1234
uid           Your Name <user@example.com>
ssb   rsa4096 2020-01-01 [E]
```

Export private key.

```bash
$ gpg --export-secret-keys ABCD1234 > private.key
```

Copy and import private key.

```bash
$ gpg --import private.key
```

### xsel

`pbcopy` and `pbpaste` commands are not available in Linux.
However, we can replicate the functionality of `pbcopy` and `pbpaste` commands to use `xsel` and add alias into the `.bashrc`.

```bash
$ sudo apt install xsel
```
