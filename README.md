# Nic's dotfile

## Usage

### Installation and Requisites:

#### Automatic installer

If you already install `git` in your machine, and you trust me and my automatic install shell script, you can install my vimrc via `curl` or `wget`, just copy one of the following line and paste in terminal:

1. via `curl`:

    `sh <(curl -L https://github.com/niclin/dotfile/raw/master/utils/install_zhTW.sh)`

2. or via `wget`:

    `sh <(wget --no-check-certificate https://github.com/niclin/dotfile/raw/master/utils/install_zhTW.sh -O -)`

This will update all installed plugins using Vundle's :PluginInstall! command. Any errors encountered during this process may be resolved by clearing out the problematic directories in ~/.vim/bundle. :help PluginInstall provides more detailed information about Vundle.


#### Fonts

[PowerLine](https://github.com/supermarin/powerline-fonts)