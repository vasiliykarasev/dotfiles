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

if true
then
  echo "Let's install lsd"
  LSD=/tmp/lsd.deb
  sudo wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb -O ${LSD} && sudo dpjg -i ${LSD}
if
if true
then
  echo "lsd needs nerdfonts"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/3270.zip -O /tmp/3270.zip
  unzip /tmp/3270.zip
  mv 3270* ~/.fonts/
fi

