#!/bin/sh
# Forked from z3bra's info.sh
# Runs in bash, because dash doesn't like colours.
gitdir=https://github.com/japanoise/
myblog=http://blog.kingdomofmysteries.xyz/

if emerge --help >/dev/null 2>&1; then
	#system is Gentoo or variant
	system=Gentoo
	if ! eix --help >/dev/null 2>&1; then
		echo "This script requires app-portage/eix to be installed"
		exit 1
	fi
	pkgnum=$(EIX_LIMIT=0 eix '-I*' --format '<installedversions:NAMEVERSION>' | wc -l)
	if [ -z "$birthd" ]
	then
		birthd=$(sudo sed -e'1q' /var/log/emerge.log | sed -e's/\([0-9]*\):.*/@\1/' | date -f- +"%Y.%m.%d")
		echo "It would be best if you put birthd=$birthd after the #! line in $0 so I don't have to ask you for your password" >&2
	fi
else
	if pacman -h >/dev/null 2>&1; then
		#system is Arch; this will need testing
		system=Arch
		pkgnum=`pacman -Q|wc -l`
		birthd=`sed -n '1s/^\[\([0-9-]*\).*$/\1/p' /var/log/pacman.log | tr - .`
	fi
fi

reset=$(printf '\033[0m')
c00=$(printf '\033[0;30m')
c01=$(printf '\033[0;31m')
c02=$(printf '\033[0;32m')
c03=$(printf '\033[0;33m')
c04=$(printf '\033[0;34m')
c05=$(printf '\033[0;35m')
c06=$(printf '\033[0;36m')
c07=$(printf '\033[0;37m')
c08=$(printf '\033[1;30m')
c09=$(printf '\033[1;31m')
c10=$(printf '\033[1;32m')
c11=$(printf '\033[1;33m')
c12=$(printf '\033[1;34m')
c13=$(printf '\033[1;35m')
c14=$(printf '\033[1;36m')
c15=$(printf '\033[1;37m')

f0=$(printf '\033[1;30m')
f1=$(printf '\033[1;37m')
f2=$(printf '\033[0;37m')

kernel=$(uname -rmo)
cpuspe="$(sed -n '/model\ name/s/^.*:\ //p' /proc/cpuinfo | uniq) (x$(nproc))"

if [ -n "$DISPLAY" ]; then
    wmname=$(xprop -root _NET_WM_NAME|cut -d\" -f2) 
    termfn=$(sed -n 's/^[^!]*font: xft:\([^:]*\).*/\1/p' ~/.Xresources|sed 1q)
    systfn=$(sed -n 's/^.*font.*"\(.*\)".*$/\1/p' ~/.gtkrc-2.0)
else
    wmname="none"
    termfn="none"
    systfn="none"
fi


cat << EOF
${c00}▉▉  | ${f1}OS ${f0}........... $f2$system
${c08}  ▉▉| ${f1}name ${f0}......... $f2${HOSTNAME:-$(hostname)}
${c01}▉▉  | ${f1}birth day${f0}..... $f2$birthd
${c09}  ▉▉| ${f1}packages ${f0}..... $f2$pkgnum
${c02}▉▉  | 
${c10}  ▉▉| ${f1}wm ${f0}........... $f2$wmname
${c03}▉▉  | ${f1}shell ${f0}........ $f2$SHELL
${c11}  ▉▉| ${f1}terminal ${f0}..... $f2$TERM
${c04}▉▉  | ${f1}term font ${f0}.... $f2$termfn
${c12}  ▉▉| ${f1}system font ${f0}.. $f2$systfn
${c05}▉▉  | 
${c13}  ▉▉| ${f1}kernel ${f0}....... $f2$kernel
${c06}▉▉  | ${f1}processor ${f0}.... $f2$cpuspe
${c14}  ▉▉| 
${c07}▉▉  | ${f1}blog ${f0}......... $f2$myblog
${c15}  ▉▉| ${f1}git repos ${f0}.... $f2$gitdir${reset}
EOF
