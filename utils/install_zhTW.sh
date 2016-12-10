# my VIMRC and plugins installer
#
# created by Eddie Kao <eddie@digik.com.tw>
# just for installing my .vim configurations and plugins in one command.
#

vim_folder=~/.vim
vim_rc=~/.vimrc
vim_rc_lc=~/.vimrc.local
vim_bundles=~/.vimrc.bundles
vim_bundles_lc=~/.vimrc.bundles.local
backup_rand=$RANDOM

# detect if there's a .vim folder
if [ -d $vim_folder ]
then
  echo "\033[0;31m您已經有一個 .vim 目錄..\033[0;m"
  read -p "請問要先替您進行備份嗎? [y/n] " ans
  if [ "$ans" == "y" ]
  then
    echo "您原本的 $vim_folder 備份至 $vim_folder-$(date +%Y%m%d)-$backup_rand"
    mv $vim_folder $vim_folder-$(date +%Y%m%d)-$backup_rand
  fi
fi

echo $vim_rc

# check if vimrc is already exist
if [ -L $vim_rc ] || [ -f $vim_rc ]
then
  echo "\033[0;31m您已經有一個 .vimrc 設定檔..\033[0;m"
  read -p "請問要先替您進行備份嗎? [y/n] " ans
  if [ "$ans" == "y" ]
  then
    echo "您原本的 $vim_rc 備份至 $vim_rc-$(date +%Y%m%d)-$backup_rand"
    mv $vim_rc $vim_rc$(date +%Y%m%d)-$backup_rand
  fi
fi

# check if git is installed
hash git >/dev/null && /usr/bin/env git clone git@github.com:niclin/dotfile.git ~/.vim || {
  echo "您必須先安裝 Git!"
  exit
}

# make a symbolic link
echo ""
echo "即將替您安裝Nic's dotfile："
echo ""
ln -s $vim_folder/.vimrc $vim_rc
ln -s $vim_folder/.vimrc.local $vim_rc_lc
ln -s $vim_folder/.vimrc.bundles $
ln -s $vim_folder/.vimrc.bundles.local $vim_bundles_lc

echo "完成安裝"

exit
