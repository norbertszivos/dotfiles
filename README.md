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
# It is only needed if you don't want to use Nerd Fonts.
$ sudo apt install fonts-powerline

$ sudo git clone -b my_prompt https://github.com/norbertszivos/bash-git-prompt.git /usr/local/share/bash-git-prompt --depth=1
```

The other configs for *bash-git-prompt* already in the `bash-git-prompt/prompt.sh` and `.bashrc` file.
See `prompt.sh` [here](https://github.com/norbertszivos/bash-git-prompt/blob/my_prompt/prompt.sh).

Configure the root's prompt as well. Paste the line below into `/root/.bashrc` file.

```bash
source /usr/local/share/bash-git-prompt/prompt.sh
```

### ssh

If `.ssh` folder is not existing, then create a new folder.

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

Or generate a new one.

```bash
$ ssh-keygen -t rsa -b 4096 -C "user@example.com"
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

Or generate a new one.

```bash
$ gpg --full-generate-key
$ gpg --list-secret-keys --keyid-format LONG
```

### xsel

`pbcopy` and `pbpaste` commands are not available on Linux.
However, we can replicate the functionality of `pbcopy` and `pbpaste` commands to use `xsel` and add alias into the `.bashrc`.

```bash
$ sudo apt install xsel
```

### tmux

Install tmux plugin manager.

```bash
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
$ tmux
```

Then press `prefix` + <kbd>I</kbd> (capital i, as in **I**nstall) to fetch the plugins.

### vim

```bash
$ sudo apt install vim curl
```

Vim automatically installs the plugin manager, if it is missing.
To install the other plugins, run this command `:PlugInstall`.

Add crontab to delete all temporary folders which are older than 7 days.

```bash
$ crontab -e

0 10 * * 1 find ~/.vim/tmp/* -mtime +7 -type d -exec rm -rf {} \;
```

#### vimcaps

Never be bothered by caps lock.

For Linux users, you need to compile the library manually, or let vimcaps compile it automatically,
but make, gcc, Xlib must be installed first.

```bash
$ sudo apt install make gcc libx11-dev
```

#### Nerd Fonts

Download Nerd Fonts, e.g. UbuntuMono Nerd Font from the [Nerd Fonts](https://www.nerdfonts.com/font-downloads) homepage.
After to extract the downloaded file, double-click on a font file. It will open the file in the Font Viewer.
In there, you can see the option to install the font in the top right corner.

#### Ripgrep

Use Ripgrep to find files in Vim.

If you run Debian Buster (currently Debian stable) or Ubuntu Cosmic (18.10 or newer)
ripgrep is available using the same packaging as Debian:

```bash
$ sudo apt-get install ripgrep
```

Ripgrep can be installed using a binary .deb file provided in each ripgrep release.

```bash
$ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.0/ripgrep_12.1.0_amd64.deb
$ sudo dpkg -i ripgrep_12.1.0_amd64.deb
```

### Terminal color scheme

Visit on the [Gogh](http://mayccoll.github.io/Gogh/) website to check the color schemes for terminals.
Follow the instructions to install the chosen color scheme or clone the
[GitHub repository of Gogh](https://github.com/Mayccoll/Gogh) and use script(s) from there.
The color scheme of vim is [gruvbox](https://github.com/morhetz/gruvbox), so it is worth to choose the
same for the terminal as well: [gruvbox color scheme from Gogh](https://github.com/Mayccoll/Gogh/blob/master/themes/gruvbox-dark.sh).

### Inspiration

- [Upcase by thoughtbot](https://thoughtbot.com/upcase)
- [The Valuable Dev](https://thevaluable.dev/)
- [BARBARIANmeetsCODING](https://www.barbarianmeetscoding.com)
- and other people's dotfiles on GitHub.
