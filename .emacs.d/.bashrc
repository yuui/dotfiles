# -*- coding: iso-2022-jp -*-
## 新しく作られたファイルのパーミッションは 644 
umask 022

## core ファイルは作らせない
ulimit -c 0

## 環境変数の設定

export PAGER=less
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

if [[ "$PS1" ]]; then
  HISTSIZE=50000
  HISTFILESIZE=50000
  shopt -s histappend
  # "!"をつかって履歴上のコマンドを実行するとき、
  # 実行するまえに必ず展開結果を確認できるようにする。
  shopt -s histverify
  # 履歴の置換に失敗したときやり直せるようにする。
  shopt -s histreedit
  # 端末の画面サイズを自動認識。
  shopt -s checkwinsize
  # つねにパス名のテーブルをチェック
  shopt -s checkhash

  # i: 直前の履歴 30件を表示する。引数がある場合は過去 1000件を検索する。
  # (history で履歴全部を表示させると多すぎるので)
  function i {
      if [ "$1" ]; then history 1000 | grep "$@"; else history 30; fi
  }
  # I: 直前の履歴 30件を表示する。引数がある場合は過去のすべてを検索する。
  function I {
      if [ "$1" ]; then history | grep "$@"; else history 30; fi
  }

  # ホスト名とユーザ名の先頭 2文字をとりだす。全部だと長いので。
  #h2=`expr $HOSTNAME : '\(..\).*'`
  #u2=`expr $USER : '\(..\).*'`
  # 現在のホストによってプロンプトの色を変える。
  if [[ "$EMACS" ]]; then
    # emacs の shell モードでは制御文字を使わない簡単なプロンプト
    PS1="$u2@$h2\w\$ "
  else
    # プロンプトの設定
    if [[ "$SHELLTYPE" = session ]]; then
      # ある端末では短いプロンプトにする。
      PS1='$h2$ ';
      unset SHELLTYPE
    else
      PS1="$u2@$h2\[\e[${col}m\]\w[\!]\$\[\e[m\] "
    fi
    # 通常のプロンプト PS1 に加えて PS0 という変数を設定する。
    # (これは bash は何も関知しない、あとで述べる px というコマンドが使う)
    # 通常のプロンプトでは現在のカレントディレクトリのフルパス名を
    # 表示するようになっているが、これが長すぎるときに PS1 と PS0 を
    # 一時的に切り換えて使う。
    PS0="$u2@$h2:\[\e[${col}m\]\W[\!]\$\[\e[m\] "

    # 端末の設定
    eval `SHELL=sh tset -sQI`
    stty dec crt erase ^H eof ^D quit ^\\ start ^- stop ^-
  fi

  # h: csh における which と同じ。
  function h { command -v $1; }

  # wi: whatis の略。指定されたコマンドの実体を表示。
  function wi {
    case `type -t "$1"` in
     alias|function) type "$1";;
     file) `command -v "$1"`;;
     function) type "$1";;
    esac
  }

  # 現在実行中のジョブを表示。
  function j { jobs -l; }

  # Wordnet を検索。
  function tmp { cd ~/tmp; }

  alias ls='ls -F'
  
  set -o noclobber

  export CVS_RSH="ssh"

  ##man() { gnudoit -q '(raise-frame (selected-frame)) (woman' \"$1\" ')' ; }

  alias which='type -path'
  alias dir='ls -l'
  alias cp='cp -i'
  #alias ls='ls -xF'
  alias h='history'
fi
