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

declare -x VISUAL="${EDITOR}"
declare -x FCEDIT="${EDITOR}"

declare -x PROMPT_COMMAND='PS1="$(~/src/promptprint/promptprint $?)"; history -a;'

declare -x HISTFILE=~/.bash_history
declare -x HISTCONTROL=ignoreboth:erasedups
declare -x HISTSIZE=-1

declare -x BROWSER=chromium

declare -x CCACHE_PATH="/usr/bin"
declare -x GCC_COLORS=always
declare -x CXXFLAGS="-fdiagnostics-color=always -mtune=native -march=native"
declare -x CFLAGS="-fdiagnostics-color=always -mtune=native -march=native"

# Unfortunately crashes a bunch of crappy applications, like Audacity
# But better to be reminded about how crappy it is
declare -x MALLOC_CHECK_=1

# Basically just to limit the absurd number of decimal points
declare -x BC_ENV_ARGS=~/.bcrc

#declare -x WINEARCH="win32"

declare -x QT_NO_GLIB=1
declare -x QT_FORCE_STDERR_LOGGING=1
declare -x QT_AUTO_SCREEN_SCALE_FACTOR=0
declare -x QT_QPA_PLATFORMTHEME=sandsmark

declare -x QTC_HELPVIEWER_BACKEND=textbrowser

declare -x QTKEYCHAIN_BACKEND=kwallet5

## Surprisingly, GTK is shit!
## Unsurprisingly, wxWidgets is even shittier, and breaks if we use xim. So we
## can't get proper compose sequences in GTK apps at all.
## Yay.
# declare -x GTK_IM_MODULE=xim

declare -x LSAN_OPTIONS=suppressions=${HOME}/.lsan.suppressions

# Not the best way, but simplest and fastet to check if the nvidia driver is
# installed
if [ ! -f "/usr/lib/modprobe.d/nvidia.conf" ]; then
    declare -x LIBVA_DRIVER_NAME=iHD
    declare -x VDPAU_DRIVER=va_gl
fi

# Java is retarded
declare -x _JAVA_AWT_WM_NONREPARENTING=1
declare -x _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
# Gradle is retarded
declare -x GRADLE_OPTS=-Dorg.gradle.daemon=false

# Dumb stuff
declare -x IDF_PATH=/home/sandsmark/src/esp-idf/

# Dumb libreoffice defaults to gtk
declare -x SAL_USE_VCLPLUGIN=kf5

# Looks like shit, but enable by default for some fucking reason when using the kf5 plugin
declare -x SAL_VCL_QT5_USE_CAIRO=0

# Since Google™ decided to restrict the chromium keys, use the Chrome™ ones
declare -x GOOGLE_DEFAULT_CLIENT_ID=77185425430.apps.googleusercontent.com
declare -x GOOGLE_DEFAULT_CLIENT_SECRET=OTJgUOQcT7lO7GsGZq2G4IlT
declare -x GOOGLE_API_KEY=AIzaSyBOti4mM-6x9WDnZIjIeyEU21OpBXqWBgw

#################
# shell variables

set -o noclobber
set -o physical

shopt -s cdspell        # Correct minor spelling mistakes in cd
shopt -s dirspell       # Try to fix spelling when completing dirs
shopt -s extglob        # Use extended glob expansion, ?(), *(), etc.
shopt -s dotglob        # Include . prefixed files in glob expansion
shopt -s cmdhist        # Join multi-line commands in the history
shopt -u lithist        # Disable replace newlines with ; in history
shopt -s progcomp       # Enable extra non-builtin completions
shopt -s checkhash      # Look up commands in hash table before falling back to path search
shopt -s checkjobs      # Prompt again if exiting and have about running backround tasks
shopt -s histreedit     # Allow editing failed history search
shopt -s histappend     # Don't overwrite history
shopt -s promptvars     # Enable variable expansion in prompts
shopt -s cdable_vars    # Assume arguments to cd are variables if they aren't a dir
shopt -s hostcomplete   # Attempt to expand hostnames when completing words with @
shopt -s expand_aliases # Use aliases
shopt -s globstar       # Use ** for recursive matching
shopt -s interactive_comments # Ignore comments in interactive shells

stty werase undef
bind '\C-w:shell-backward-kill-word'

# Make Alt+, select the first argument, matching Alt+. for selecting the last argument
bind '"\e,":yank-nth-arg'
bind '"\e[1;5D":shell-backward-word'
bind '"\e[1;5C":shell-forward-word'

# Alt + {1,2,3} to select argument {1,2,3}
bind '"\e1":yank-nth-arg 1'
bind '"\e2":yank-nth-arg 2'
bind '"\e3":yank-nth-arg 3'

#  Update LINES and COLUMNS variables after commands complete
[[ $DISPLAY ]] && shopt -s checkwinsize

#########
# aliases

alias vi=vim
alias ls='ls -C -h --color=auto'
alias grep='grep --color=auto'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias ix="curl -n -F 'f:1=<-' http://ix.io"
alias ip="ip -c"
alias mv="mv -i"

# feh sucks, but muscle memory is a bitch
alias feh=qeh

###########
# functions

# --ignore = continue even if failing to set iopri
function make    { ionice --ignore --class 3 nice make $@; }

function find  { stderred find "$@"; }
function ff    { find . -name $@; }

function cd    {
    builtin cd "$@" || return
    OUTPUT="$(ls -C -h --color=always)"
    if (( $(grep -c . <<<"$OUTPUT") < 250 )); then
        echo "$OUTPUT";
    fi
}

function viff    {
    mapfile -t -n 2 < <(ff "$@")
    if ((${#MAPFILE[@]}==0)); then
        echo "No results"
        return
    fi
    FILE="${MAPFILE[0]}"

    echo "Open $FILE?"
    read || return
    /usr/bin/vim "$FILE"
}

function mkcd    { mkdir "$@" && builtin cd "$@"; }
function fix-whiteboard { convert "$@" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$@.fixed.jpg"; }

function mac-vendor {
    MAC="$(echo $@ | sed 's/ //g' | sed 's/-//g' | sed 's/://g' | cut -c1-6)";
    if [[ -z "$MAC" ]]; then
        return
    fi

    result="$(grep -i -A 4 ^$MAC ~/oui.txt)";

    if [ "$result" ]; then
        echo "For the MAC $1 the following information is found:"
        echo "$result"
    fi

}

# Rust is a fucking clustertrainfuck
function makepkgjail_net {
    printf '\033[33;5m\nRUNNING UNPROTECTED\n\n\033[00m'
    supernice firejail --allow-debuggers --profile=makepkg /usr/bin/makepkg $@ || return 1
    printf '\033[33;5m!!!!!!\nREMEMBER TO ENSURE THE RUST CRAP IS JAILED!\n!!!!!!\n\n\033[00m'
}

function supernice {
    ionice --ignore --class 3 nice -n 19 $@ || return 1
}

function makepkgjail {
    supernice firejail --allow-debuggers --profile=makepkg-nonet /usr/bin/makepkg $@ || return 1
}

function makepkg {
    # Download sources
    echo "Downloading source"
    supernice firejail --allow-debuggers --profile=makepkg /usr/bin/makepkg --verifysource || return 1
    # Install deps
    echo "Installing deps"
    supernice /usr/bin/makepkg --verifysource --holdver --noextract --syncdeps --nobuild --noprepare || return 1
    # Unpack the sources
    echo "Unpacking source"
    makepkgjail --nobuild --holdver $@ || return 1
    # Do the actual build
    echo "Building"
    makepkgjail --holdver $@ || return 1
}

function depinst {
    makepkg $@ || return 1
    for PACKAGE in $(makepkgjail --packagelist); do
        echo "Installing $PACKAGE as dependency"
        sudo pacman -U --asdeps "$PACKAGE"
    done
}

function pkginst {
    makepkg $@ || return 1
    for PACKAGE in $(makepkgjail --packagelist); do
        echo "Installing $PACKAGE"
        sudo pacman -U "$PACKAGE" || return 1
    done
}

function git-owner {
    git blame -w -M -C -C --line-porcelain "$1" | grep '^author ' | sort -f | uniq -ic | sort -h
}

function git-repo-owner {
    find -type f -exec git blame -w -M -C -C --line-porcelain {} \; 2>/dev/null | grep '^author ' | sort -f | uniq -ic | sort -h
}

function vim {
    # Handle filename:linenumber
    if [[ "$@" =~ (.*):([0-9]+) ]]; then
        /usr/bin/vim +"${BASH_REMATCH[2]}" "${BASH_REMATCH[1]}"
        return $?
    fi

    # Handle standard type of 'vi vi'
    if [[ "$1" = "vi" ]]; then
        /usr/bin/vim "$2"
        return $?
    fi

    # We don't handle more than one file below
    if [[ "$#" -ne "1" ]]; then
        /usr/bin/vim "$@"
        return $?
    fi

    # Handle standard a/ and b/ prefix from git diff
    # Can't use noprefix config in git because that screws up patches
    # TODO: handle multiple arguments
    if [[ "$1" =~ (a\/|b\/)(.*) ]] && [[ ! -e "$1" ]]; then
        FIXED="${BASH_REMATCH[2]}"
        if [[ -e "$FIXED" ]]; then
            /usr/bin/vim "$FIXED"
            return $?
        fi
    fi

    /usr/bin/vim "$@"
    return $?
}

########
# prompt

PS1="$(~/src/promptprint/promptprint)"
