function conf() {
  directories_list=($(find -L $HOME -maxdepth 1 -type d -name ".*$1*"))
  directories_list+=($(find -L $HOME/.config -maxdepth 1 -type d -name "*$1*"))
  directories_list+=($(find -L /etc -maxdepth 1 -type d -name "*$1*"))
  directories=""
  for d in $directories_list
  {
    directories+="(dir) "
    directories+=$d
    directories+="\n"
  }
  files_list=($(find -L $HOME -maxdepth 1 -type f -name ".*$1*"))
  files_list+=($(find -L $HOME/.config -maxdepth 1 -type f -name "*$1*"))
  files_list+=($(find -L /etc -maxdepth 1 -type f -name "*$1*"))
  files=""
  for d in $files_list
  {
    files+="(file) "
    files+=$d
    files+="\n"
  }
  fzf_list=$directories"\n"$files
  fzf_result=$(echo $fzf_list | fzf --preview 'bat --color=always $(echo {} | awk '"'"'{print $2}'"'"')' --border --prompt 'Please choose a file > ')
  fzf_result=($(echo $fzf_result))
  target=$fzf_result[2]
  if [[ ! -z $target ]] {
    if [[ -d $target ]] {
      cd $target
    } elif [[ -w $target ]] {
      $EDITOR $target
    } else {
      sudo $EDITOR $target
    }
  }
}

# [[ -f $HOME/.tmux.conf.local ]] && tmux_conf_file=$HOME/.tmux.conf.local   # in case oh-my-tmux is installed
#
# function conf() {
#   if [[ -z $confer_filetable ]] {
#     typeset -A confer_filetable
#     confer_filetable=(
#       vim "$HOME/.vimrc"
#       zsh "$HOME/.zshrc"
#       i3 "$HOME/.config/i3/config"
#       tmux "$HOME/.tmux.conf.local"
#       haproxy "$HOME/.haproxy.cfg"
#       proxychains "/etc/proxychains.conf"
#       dunst "$HOME/.config/dunst/dunstrc"
#       ranger "$HOME/.config/ranger/rc.conf"
#       termite "$HOME/.config/termite/config"
#       jupyter "$HOME/.jupyter/jupyter_notebook_config.py"
#       polybar "$HOME/.config/polybar/config"
#       ssh "$HOME/.ssh/config"
#       urxvt "$HOME/.Xdefaults"
#       compton "$HOME/.config/compton.conf"
#       rime "$HOME/.config/fcitx/rime/custom.yaml"
#     )
#   }
#   # try to set the configure file as the value of the variable whose name is $1
#   filepath=${(P)1}
#
#   # if not found, try to find the configure file from the file table
#   [[ -z $filepath ]] && filepath=$confer_filetable[$1]
#   echo $filepath
#
#   if [[ $filepath ]] {
#     if [[ -z $EDITOR ]] {
#       echo 'No EDITOR is specified, use vim'
#       EDITOR=vim
#     }
#     echo "editing with $EDITOR"
#
#     $EDITOR $filepath
#   } elif {! [ -z $1 ]} {
#     echo "confer: configure file not find, but we tried to find these :"
#     find $HOME/ -maxdepth 1 -name "*$1*"
#     find $HOME/.config/ -maxdepth 2 -name "*$1*"
#   } else {
#     echo 'Start to configure a program with $EDITOR'
#     echo 'Example:'
#     echo '"conf vim" to configure vim'
#     echo 'The path of the configure file will be choosed automatically.'
#     echo 'Or you can specify the path of a program by define a variable:'
#     echo 'vim="$HOME/.vim"'
#     echo 'And then "conf vim" will open "$HOME/.vim"'
#   }
# }
