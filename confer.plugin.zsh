[[ -f $HOME/.tmux.conf.local ]] && tmux_conf_file=$HOME/.tmux.conf.local   # in case oh-my-tmux is installed

typeset -A filetable
filetable=(
  vim "$HOME/.vimrc"
  zsh "$HOME/.zshrc" 
  i3 "$HOME/.config/i3/config" 
  tmux "$HOME/.tmux.conf.local"
  haproxy "$HOME/.haproxy.cfg"
  proxychains "/etc/proxychains.conf"
  dunst "$HOME/.config/dunst/dunstrc"
  ranger "$HOME/.config/ranger/rc.conf"
  termite "$HOME/.config/termite/config"
  jupyter "$HOME/.jupyter/jupyter_notebook_config.py"
  polybar "$HOME/.config/polybar/config"
  ssh "$HOME/.ssh/config"
  urxvt "$HOME/.Xdefaults"
  compton "$HOME/.config/compton.conf"
  rime "$HOME/.config/fcitx/rime/custom.yaml"
)

function conf() {
  # try to set the configure file as the value of the variable whose name is $1
  filepath=${(P)1}
  # if not found, try to find the configure file from the file table
  [[ -z $filepath ]] && filepath=$filetable[$1]

  if [[ $filepath ]] {
    if [[ -z $EDITOR ]] {
      echo 'No EDITOR is specified, use vim'
      EDITOR=vim
    }
    echo "editing with $EDITOR"

    $EDITOR $filepath
  } elif {! [ -z $1 ]} {
    echo "confer: configure file not find, but we tried to find these :"
    find $HOME/ -maxdepth 1 -name "*$1*"
    find $HOME/.config/ -maxdepth 2 -name "*$1*"
  } else {
    echo 'Start to configure a program with $EDITOR'
    echo 'Example:'
    echo '"conf vim" to configure vim'
    echo 'The path of the configure file will be choosed automatically.'
    echo 'Or you can specify the path of a program by define a variable:'
    echo 'vim="$HOME/.vim"'
    echo 'And then "conf vim" will open "$HOME/.vim"'
  }
}
