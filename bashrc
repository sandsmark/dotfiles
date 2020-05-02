#############################################
# ##### SANDSMARK'S hobbgobble bashrc ##### #
#############################################
# ##### COPYBLEH 2010 ##### #
#############################

#########
# general

umask 022

###############
# env variables

# Path is special, because some scripts in /etc/profile.d/ likes to add stuff several times
# So don't care if we add something already there here, and just remove duplicates afterwards
declare -x PATH="/usr/local/bin:/usr/lib/ccache/bin/:$PATH"
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"

declare -x LS_COLORS='no=01;37:fi=01;37:di=01;34:ln=01;36:pi=01;32:so=01;35:do=01;35:bd=01;33:cd=01;33:ex=01;31:mi=00;37:or=00;36:'

declare -x PAGER='less'

declare -x EDITOR='vim'
declare -x TERM='xterm-256color'

declare -x VISUAL="${EDITOR}"
declare -x FCEDIT="${EDITOR}"

declare -x PROMPT_COMMAND='ret=$?; if [ $ret -ne 0 ] ; then echo -e "\007returned \033[01;31m$ret\033[00;00m"; fi; history -a'

declare -x HISTFILE=~/.bash_history
declare -x HISTCONTROL=ignoreboth:erasedups
declare -x HISTSIZE=-1

declare -x BROWSER=chromium

declare -x CCACHE_PATH="/usr/bin"
declare -x GCC_COLORS=always
declare -x CXXFLAGS=-fdiagnostics-color=always
declare -x CFLAGS=-fdiagnostics-color=always

declare -x MALLOC_CHECK_=1

declare -x BC_ENV_ARGS=~/.bcrc

#declare -x WINEARCH="win32"

declare -x QT_NO_GLIB=1

declare -x QTC_HELPVIEWER_BACKEND=textbrowser

declare -x QT_AUTO_SCREEN_SCALE_FACTOR=0

declare -x QTKEYCHAIN_BACKEND=kwallet5

declare -x QT_QPA_PLATFORMTHEME=sandsmark

declare -x LSAN_OPTIONS=suppressions=${HOME}/.lsan.suppressions

# Not the best way, but simplest and fastet to check if the nvidia driver is
# installed
if [ ! -f "/usr/lib/modprobe.d/nvidia.conf" ]; then
    declare -x LIBVA_DRIVER_NAME=i965
    declare -x VDPAU_DRIVER=va_gl
fi

# Java is retarded
declare -x _JAVA_AWT_WM_NONREPARENTING=1
# Gradle is retarded
declare -x GRADLE_OPTS=-Dorg.gradle.daemon=false


#################
# shell variables

set -o noclobber
set -o physical

shopt -s cdspell
shopt -s extglob
shopt -s dotglob
shopt -s cmdhist
shopt -s lithist
shopt -s progcomp
shopt -s checkhash
shopt -s histreedit
shopt -s histappend
shopt -s promptvars
shopt -s cdable_vars
shopt -s checkwinsize
shopt -s hostcomplete
shopt -s expand_aliases
shopt -s interactive_comments

#########
# aliases

alias vi=vim
alias ls='ls -C -h --color=auto'
alias grep='grep --color=auto'
alias feh='feh -.'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias ix="curl -n -F 'f:1=<-' http://ix.io"

###########
# functions

function x     { exit    $@; }
function z     { suspend $@; }
function j     { jobs -l $@; }

function p     { ${PAGER}  $@; }
function e     { ${EDITOR} $@; }

function c     { clear; }
function h     { history $@; }
function hcc   { hc;c; }

function cx    { hc;x; }

function ..    { cd ..; }

function l    { ls --group-directories-first --color=auto -Fq  $@; }
function ll    { ls --group-directories-first --color=auto -Fql $@; }

function make    { ionice nice make $@; }

function find  { stderred find "$@"; }
function ff    { find . -name $@; }

function dmsg  { dmesg | p; }

function cd    { builtin cd "$@" && if [ "$(/usr/bin/ls -U1q | wc -l)" -lt 250 ]; then ls; fi; }

function mkcd    { mkdir "$@" && builtin cd "$@"; }
function fix-whiteboard { convert "$@" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$@.fixed.jpg"; }


function h2d    { echo "ibase=16; $@"|bc; }
function h2b    { echo "ibase=16;obase=2; $(echo $@ | tr [:lower:] [:upper:])" |bc; }
function b2h    { echo "ibase=2;obase=16; $@"|bc; }
function d2h    { echo "obase=16; $@"|bc; }

function mac-vendor {
    MAC="$(echo $@ | sed 's/ //g' | sed 's/-//g' | sed 's/://g' | cut -c1-6)";

    result="$(grep -i -A 4 ^$MAC ~/oui.txt)";

    if [ "$result" ]; then
        echo "For the MAC $1 the following information is found:"
        echo "$result"
    else
        echo "MAC $1 is not found in the database."
    fi

}

function vim    {
    if [[ "$@" =~ (.*):([0-9]+) ]]; then
        /usr/bin/vim +"${BASH_REMATCH[2]}" "${BASH_REMATCH[1]}"
    else
        /usr/bin/vim "$@"
    fi
}

#############
# completions

complete -W '$(echo $(cut -d\  -f1 < ~/.ssh/known_hosts | cut -d, -f1))' mosh

########
# prompt

rgb_restore='\[\033[00m\]'
rgb_black='\[\033[00;30m\]'
rgb_firebrick='\[\033[00;31m\]'
rgb_red='\[\033[01;31m\]'
rgb_forest='\[\033[00;32m\]'
rgb_green='\[\033[01;32m\]'
rgb_brown='\[\033[00;33m\]'
rgb_yellow='\[\033[01;33m\]'
rgb_navy='\[\033[00;34m\]'
rgb_blue='\[\033[01;34m\]'
rgb_purple='\[\033[00;35m\]'
rgb_magenta='\[\033[01;35m\]'
rgb_cadet='\[\033[00;36m\]'
rgb_cyan='\[\033[01;36m\]'
rgb_gray='\[\033[00;37m\]'
rgb_white='\[\033[01;37m\]'

rgb_std="${rgb_white}"

if [ `id -u` -eq 0 ]
then
    rgb_usr="${rgb_red}"
else
    rgb_usr="${rgb_green}"
fi

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


export ELIDED_PATH='$(echo -n "${PWD/#$HOME/\~}" | awk -F "/" '"'"'{
if (length($0) > 50) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
else if (NF>3) print $1 "/" $2 "/.../" $NF;
else print $1 "/.../" $NF; }
else print $0;}'"'"')'

PS1="${rgb_gray}`hostname`${rgb_usr}: ${rgb_std}${ELIDED_PATH}/${rgb_cadet}\$(parse_git_branch)${rgb_restore} "

unset   rgb_restore   \
        rgb_black     \
        rgb_firebrick \
        rgb_red       \
        rgb_forest    \
        rgb_green     \
        rgb_brown     \
        rgb_yellow    \
        rgb_navy      \
        rgb_blue      \
        rgb_purple    \
        rgb_magenta   \
        rgb_cadet     \
        rgb_cyan      \
        rgb_gray      \
        rgb_white     \
        rgb_std       \
        rgb_usr

