# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#**********************************
# My global aliases

alias ls='ls -hFG'
alias ls='ls -hF --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias lla='ll -A'
alias lld='ll -d'
alias lltime='ll -tr'
alias llsize='ll -Sr'

alias egrep='egrep --color=auto'
alias grep='egrep'
alias psg='ps aux | grep -v grep | grep'
alias hist='history | tail -30'
alias jobs='jobs -l'

alias df='df -Ph'
alias du='du -sh'

alias mv='mv -i'

alias less='less -FX -R'

alias grepGreen='GREP_COLOR=32 grep'
alias grepYellow='GREP_COLOR=33 grep'
alias grepBlue='GREP_COLOR=34 grep'

alias freeram="(free -tm | head -3 | tail -1 | sed -s 's/ \+/ /g' | cut -d' ' -f 4)"

alias nssh='ssh -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no'

#**********************************
# My local aliases

#**********************************
# Unordered aliases

alias date_time='\date --rfc-3339=seconds | tr "-" " " | awk "{ print \$4 }"'
alias date='date --rfc-3339=seconds | tr " " "T"'
#alias mplayer='mplayer -cache 1024 -cache-min 0' # cache size in kb, cache-min is percent to wait before playing
alias htop='htop --sort-key PERCENT_CPU'
alias cclocate='locate -d ~/dev/chromium/mlocate.db -e -b'
alias top='top -o cpu'

alias ack='ack --color'
alias git_commit_counts='git shortlog -sn --no-merges'

alias openxcode='open platforms/ios/*.xcodeproj/'

alias clang++='~/dev/ext/llvm_build/Release/bin/clang++ -stdlib=libc++ -nostdinc++ -I ~/dev/ext/libcxx/include -L ~/dev/ext/libcxx/lib'

alias tommy="echo -e '\033]50;SetProfile=tommy.hot.corp.google.com\a' && mosh tommy.hot.corp.google.com && source ~/.bashrc"
