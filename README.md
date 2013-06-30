Installation
============

Run this on the terminal :

```bash
# Clone main repository
git clone https://github.com/fxthomas/dotfiles.git ~/.dotfiles

# Initialize the submodules
cd ~/.dotfiles; git submodule init; git submodule update

# Link the dotfiles to your home directory, but remove `.git` and `.gitignore`
ln -s ~/.dotfiles/.* ~/; rm ~/{.git,.gitignore}

# Install Vim bundles
vim -E -c BundleInstall -c 'qa!'
```

Compile Vimproc for your architecture (replace `make_mac` by `make_unix` or whatever you have) :

```bash
cd ~/.dotfiles/.vim/bundle/vimproc.vim && make -f make_mac.mak
```
