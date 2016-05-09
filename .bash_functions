# Function which adds an alias to the current shell and to
# the ~/.bash_aliases file.
add-alias ()
{
   local name=$1 value="$2"
   echo alias $name=\'$value\' >>~/.bash_aliases
   eval alias $name=\'$value\'
   alias $name
}

# "repeat" command.  Like:
#
#       repeat 10 echo foo
repeat ()
{
    local count="$1" i;
    shift;
    for i in $(seq 1 "$count");
    do
        eval "$@";
    done
}

# "clean" command.  Like:
#
#       clean
clean ()
{
    echo -n "Really clean this directory? [y/n] ";
    read yorn;
    if [ "$yorn" = "y" ]; then
       rm -f \#* *~ .*~ *.swp .*.swp;
       echo "Cleaned.";
    else
       echo "Not cleaned.";
    fi
}

function highlight ()
{
    C_PATT=`echo -e '\033[33;01m'`
    C_NORM=`echo -e '\033[m'`

    sed "s/$1/${C_PATT}&${C_NORM}/gi"
}

function cleantemplates ()
{
    C_PATT=`echo -e '\033[31;11m'`
    C_NORM=`echo -e '\033[m'`

    sed "s/<.*>/${C_PATT}&${C_NORM}/gi"
}

function up ()
{
    local count="$1" path;
    for i in $(seq $count); do
      path+="../"
    done
    cd $path
}

function mem ()
{
  echo $(($(ps aux | grep $1 | awk '{print $6}' | paste -sd+ | bc)/1024))M
}

function memall ()
{
  for i in $(ps aux | grep mmocny | awk '{print $11}' | while read i; do basename $i; done | sort | uniq); do echo $(mem $i) $i; done | sort -n
}

function remove_color_codes ()
{
  sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
}

function lllll ()
{
  CURRWS=$(wmctrl -d | awk '$2 == "*" {print $1}')
  PREFIX=""
  if [ $# -gt 0 ]; then
    PREFIX=$(basename "$1")
  fi
  FILENAME=$(echo $PREFIX | awk 'BEGIN { FS=":" }; { print $1 }')
  LINENUM=$(echo $PREFIX | awk 'BEGIN { FS=":" }; { print $2 }')

  # Scan open gvim windows
  LIST=$(wmctrl -l -x | awk -v cws="$CURRWS" '$2 == cws && tolower($0) ~ "gvim" {print $5}' | sort | grep "${FILENAME}" | sed '/^$/d')
  ACTION="wmctrl"
  
  # If none, locate in custom db
  if [ "$LIST" == "" ]; then
    LIST=$(locate -d ~/dev/chromium/mlocate.db -e -b "$FILENAME" | while read i; do test -f "$i" && echo "$i"; done | \grep -v "/src/out" | \grep "$(pwd -P)" | cut -c$(pwd -P | wc -c)- | cut -c2-)
    ACTION="gvim"
  fi
  
  COUNT=$(echo "$LIST" | wc -l)
  if [ $COUNT -eq 0 ]; then
    # If still none, fail :(
    false;
    return;
  elif [ $COUNT -eq 1 ]; then
    # Gotcha
    i=1;
  else
    # Which one?
    echo "$LIST" | nl;
    echo -n "Select: ";
    read i; # TODO: replace with select builtin
  fi;

  TARGET=$(echo "$LIST" | remove_color_codes | sed "${i}q;d");
  if [ $ACTION == "wmctrl" ]; then
    wmctrl -a $TARGET
    echo "Switched to $TARGET" | highlight "$TARGET"
  elif [ $ACTION == "gvim" ]; then
    gvim $TARGET +${LINENUM}
    #TARGET=$(basename $TARGET)
    echo "Opened up $TARGET" | grep "$TARGET"
  fi
}

function l ()
{
  PREFIX=""
  if [ $# -gt 0 ]; then
    PREFIX=$(basename "$1")
  fi
  FILENAME=$(echo $PREFIX | awk 'BEGIN { FS=":" }; { print $1 }')
  LINENUM=$(echo $PREFIX | awk 'BEGIN { FS=":" }; { print $2 }')
  LIST=$(gfind -type f -name "$PREFIX*")
  if [ "x$LIST" = "x" ]; then
    LIST=$(gfind -type f -iname "*$PREFIX*")
  fi
  if [ "x$LIST" = "x" ]; then
    false;
    return;
  fi

  COUNT=$(echo "$LIST" | wc -l)
  if [ $COUNT -eq 1 ]; then
    i=1;
  else
    echo "$LIST" | nl;
    echo -n "Select: ";
    read i; # TODO: replace with select builtin
  fi;

  TARGET=$(echo "$LIST" | sed "${i}q;d");

  EXTENSION="${TARGET##*.}"
  if [ "x$EXTENSION" == "xjs" ]; then
    open $TARGET
  else
    mvim $TARGET +${LINENUM}
  fi
  echo "Opened up $TARGET" | grep "$TARGET"
}

function blamecount ()
{
   git blame --show-name $1 | cut -d\( -f2- | cut -c-14 | sort | uniq -c | sort -n
}

function lsgvim ()
{
  paste -d'/' <(wmctrl -l | grep GVIM | cut -d' ' -f6 | tr -d "()") <(wmctrl -l | grep GVIM | cut -d' ' -f5)
}

function cp_p()
{
   strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
      | awk '{
        count += $NF
            if (count % 10 == 0) {
               percent = count / total_size * 100
               printf "%3d%% [", percent
               for (i=0;i<=percent;i++)
                  printf "="
               printf ">"
               for (i=percent;i<100;i++)
                  printf " "
               printf "]\r"
            }
         }
         END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

function ernie()
{
  USER=root
  PASS=test0000
  USBDONGLE_HOSTNAME=ernie
  sshpass -p${PASS} ssh ${USER}@${USBDONGLE_HOSTNAME} -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no
}

function paths()
{
  PATHS_WITH_EDITS="$(g4 status | awk '{print $1}' | xargs -L 1 dirname | sort -u | sed -s 's/\/\/depot//')"

  PS3="Select a path: "
  select PATH_WITH_EDIT in $PATHS_WITH_EDITS; do
    g4d "$PATH_WITH_EDIT"
    break;
  done
}

function screenme()
{
  SESSION="${1}"
  screen -x -q -U -R "$SESSION" -t "$SESSION"
}

function good-morning() {
  echo "Good Morning!"
  /Users/mmocny/bin/good-morning
  sleep 3 # Not sure why, but even after mount succeeds cannot `cd` for a bit
  cd $PWD
}
