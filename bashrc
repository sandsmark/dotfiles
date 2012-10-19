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

declare -x PATH="~/bin:/usr/local/bin:$PATH"

declare -x LS_COLORS='no=01;37:fi=01;37:di=01;34:ln=01;36:pi=01;32:so=01;35:do=01;35:bd=01;33:cd=01;33:ex=01;31:mi=00;37:or=00;36:'

declare -x PAGER='less'

declare -x EDITOR='vim'

declare -x VISUAL="${EDITOR}"
declare -x FCEDIT="${EDITOR}"

declare -x HISTFILE=~/.bash_history
declare -x HISTCONTROL=ignoreboth
declare -x hISTFILESIZE=50000
declare -x HISTSIZE=500000

declare -x MPD_HOST=itk-musikk.samfundet.no
declare -x DEITY=seigo

declare -x BROWSER=chromium

unset PROMPT_COMMAND

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
shopt -s promptvars
shopt -s cdable_vars
shopt -s checkwinsize
shopt -s hostcomplete
shopt -s expand_aliases
shopt -s interactive_comments

#########
# aliases

alias vi=vim
alias ls='ls --color=auto'
alias l=ls
alias ll='ls -l'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"

###########
# functions

function x     { exit    $@; }
function z     { suspend $@; }
function j     { jobs -l $@; }

function p     { ${PAGER}  $@; }
function e     { ${EDITOR} $@; }

function c     { clear; }
function h     { history $@; }
function hc    { history -c; }
function hcc   { hc;c; }

function cx    { hc;x; }

function ..    { cd ..; }

function ll    { ls --color=auto -FAql $@; }
function lf    { ls --color=auto -FAq  $@; }

function ff    { find . -name $@; }

function dmsg  { dmesg | p; }

function cd    { builtin cd "$@" && ls; }

function psql  { LD_PRELOAD=/lib/libreadline.so.5 psql; }

#############
# completions

complete -A setopt set
complete -A user groups id
complete -A binding bind
complete -A helptopic help
complete -A alias {,un}alias
complete -A signal -P '-' kill
complete -A stopped -P '%' fg bg
complete -A job -P '%' jobs disown
complete -A variable readonly unset
complete -A file -A directory ln chmod
complete -A user -A hostname finger pinky
complete -A directory find cd pushd {mk,rm}dir
complete -A file -A directory -A user chown
complete -A file -A directory -A group chgrp
complete -o default -W 'Makefile' -P '-o ' qmake
complete -A command man which whatis whereis sudo info apropos
complete -A file {,z}cat pico nano vi {,{,r}g,e,r}vi{m,ew} vimdiff elvis emacs {,r}ed e{,x} joe jstar jmacs rjoe jpico {,z}less {,z}more p{,g}
complete -W "$(echo $(grep '^ssh ' ${HISTFILE} | sort -u | sed 's/^ssh //'))" ssh

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

[ -n "$PS1" ] && PS1="${rgb_gray}`hostname`${rgb_usr}:${rgb_std}\w/${rgb_restore} "

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

###########
# key binds

bind '"\C-t": possible-completions' # replaces 'transpose-chars'
bind '"\C-m": menu-complete'        # replaces 'transpose-words'

