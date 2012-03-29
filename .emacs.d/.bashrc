# -*- coding: iso-2022-jp -*-
## $B?7$7$/:n$i$l$?%U%!%$%k$N%Q!<%_%C%7%g%s$O(B 644 
umask 022

## core $B%U%!%$%k$O:n$i$;$J$$(B
ulimit -c 0

## $B4D6-JQ?t$N@_Dj(B

export PAGER=less
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

if [[ "$PS1" ]]; then
  HISTSIZE=50000
  HISTFILESIZE=50000
  shopt -s histappend
  # "!"$B$r$D$+$C$FMzNr>e$N%3%^%s%I$r<B9T$9$k$H$-!"(B
  # $B<B9T$9$k$^$($KI,$:E83+7k2L$r3NG'$G$-$k$h$&$K$9$k!#(B
  shopt -s histverify
  # $BMzNr$NCV49$K<:GT$7$?$H$-$d$jD>$;$k$h$&$K$9$k!#(B
  shopt -s histreedit
  # $BC<Kv$N2hLL%5%$%:$r<+F0G'<1!#(B
  shopt -s checkwinsize
  # $B$D$M$K%Q%9L>$N%F!<%V%k$r%A%'%C%/(B
  shopt -s checkhash

  # i: $BD>A0$NMzNr(B 30$B7o$rI=<($9$k!#0z?t$,$"$k>l9g$O2a5n(B 1000$B7o$r8!:w$9$k!#(B
  # (history $B$GMzNrA4It$rI=<($5$;$k$HB?$9$.$k$N$G(B)
  function i {
      if [ "$1" ]; then history 1000 | grep "$@"; else history 30; fi
  }
  # I: $BD>A0$NMzNr(B 30$B7o$rI=<($9$k!#0z?t$,$"$k>l9g$O2a5n$N$9$Y$F$r8!:w$9$k!#(B
  function I {
      if [ "$1" ]; then history | grep "$@"; else history 30; fi
  }

  # $B%[%9%HL>$H%f!<%6L>$N@hF,(B 2$BJ8;z$r$H$j$@$9!#A4It$@$HD9$$$N$G!#(B
  #h2=`expr $HOSTNAME : '\(..\).*'`
  #u2=`expr $USER : '\(..\).*'`
  # $B8=:_$N%[%9%H$K$h$C$F%W%m%s%W%H$N?'$rJQ$($k!#(B
  if [[ "$EMACS" ]]; then
    # emacs $B$N(B shell $B%b!<%I$G$O@)8fJ8;z$r;H$o$J$$4JC1$J%W%m%s%W%H(B
    PS1="$u2@$h2\w\$ "
  else
    # $B%W%m%s%W%H$N@_Dj(B
    if [[ "$SHELLTYPE" = session ]]; then
      # $B$"$kC<Kv$G$OC;$$%W%m%s%W%H$K$9$k!#(B
      PS1='$h2$ ';
      unset SHELLTYPE
    else
      PS1="$u2@$h2\[\e[${col}m\]\w[\!]\$\[\e[m\] "
    fi
    # $BDL>o$N%W%m%s%W%H(B PS1 $B$K2C$($F(B PS0 $B$H$$$&JQ?t$r@_Dj$9$k!#(B
    # ($B$3$l$O(B bash $B$O2?$b4XCN$7$J$$!"$"$H$G=R$Y$k(B px $B$H$$$&%3%^%s%I$,;H$&(B)
    # $BDL>o$N%W%m%s%W%H$G$O8=:_$N%+%l%s%H%G%#%l%/%H%j$N%U%k%Q%9L>$r(B
    # $BI=<($9$k$h$&$K$J$C$F$$$k$,!"$3$l$,D9$9$.$k$H$-$K(B PS1 $B$H(B PS0 $B$r(B
    # $B0l;~E*$K@Z$j49$($F;H$&!#(B
    PS0="$u2@$h2:\[\e[${col}m\]\W[\!]\$\[\e[m\] "

    # $BC<Kv$N@_Dj(B
    eval `SHELL=sh tset -sQI`
    stty dec crt erase ^H eof ^D quit ^\\ start ^- stop ^-
  fi

  # h: csh $B$K$*$1$k(B which $B$HF1$8!#(B
  function h { command -v $1; }

  # wi: whatis $B$NN,!#;XDj$5$l$?%3%^%s%I$N<BBN$rI=<(!#(B
  function wi {
    case `type -t "$1"` in
     alias|function) type "$1";;
     file) `command -v "$1"`;;
     function) type "$1";;
    esac
  }

  # $B8=:_<B9TCf$N%8%g%V$rI=<(!#(B
  function j { jobs -l; }

  # Wordnet $B$r8!:w!#(B
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
