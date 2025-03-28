#!/bin/bash

function link_file
{
  echo "Linking $HOME/.$1"
  ln -s "$PWD/$1" "$HOME/.$1"
}

function replace_file
{
  rm -rfv "$HOME/.$1"
  link_file $1
}

function link_dotfiles
{
  replace_all=false

  for file in $*
  do
    if [ -e "$HOME/.$file" ]
    then
      if $replace_all
      then
        replace_file $file
      else
        echo "Overwrite $HOME/.$file? [ynaq]"
        read answer
        case $answer in
          'a')
            replace_all=true
            replace_file $file
            ;;
          'y')
            replace_file $file
            ;;
          'q')
            break
            ;;
          *)
            echo "Skipping $HOME/.$file"
            ;;
        esac
      fi
    else
      link_file $file
    fi
  done
}

function install_vundle
{
  if [ ! -e $HOME/.vim/bundle/vundle ]
  then
    echo 'Installing Vundle'
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
  fi
}

function link_ssh
{
  if [ ! -h $HOME/.ssh/rc ]
  then 
    echo "Linking $HOME/.ssh/rc"
    ln -s ssh/rc $HOME/.ssh/rc
  fi
}

ignore_files='(LICENSE)|(install.sh)|(README)|(__)|(Rakefile)|(ssh)'
files=`ls | egrep -v "$ignore_files"`

link_dotfiles $files
link_ssh
install_vundle
