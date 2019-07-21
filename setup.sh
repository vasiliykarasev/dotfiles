#!/bin/bash
if true
  then
  echo "Lets install BAT"
  BAT_DEB=/tmp/bat_0.7.0_amd64.deb
  wget -O ${BAT_DEB} https://github.com/sharkdp/bat/releases/download/v0.7.0/bat_0.7.0_amd64.deb
  sudo dpkg -i ${BAT_DEB}
fi

if true
  then
  echo "Lets install FZF"
  FZF_PATH=${HOME}/Sandbox/fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ${FZF_PATH}
  ${FZF_PATH}/./install
fi

if true
then
  echo "Lets install diff-so-fancy"
  DIFF_SO_FANCY=/usr/local/bin/diff-so-fancy
  sudo wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -O ${DIFF_SO_FANCY} && sudo chmod +x ${DIFF_SO_FANCY}
  git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
fi
