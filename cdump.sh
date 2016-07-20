#!/bin/bash

c00=$'\e[0;30m'
c01=$'\e[0;31m'
c02=$'\e[0;32m'
c03=$'\e[0;33m'
c04=$'\e[0;34m'
c05=$'\e[0;35m'
c06=$'\e[0;36m'
c07=$'\e[0;37m'
c08=$'\e[1;30m'
c09=$'\e[1;31m'
c10=$'\e[1;32m'
c11=$'\e[1;33m'
c12=$'\e[1;34m'
c13=$'\e[1;35m'
c14=$'\e[1;36m'
c15=$'\e[1;37m'
code00=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?0:[ ]*\(#[0-9a-f]*\)/\1/p')
code01=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?1:[ ]*\(#[0-9a-f]*\)/\1/p')
code02=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?2:[ ]*\(#[0-9a-f]*\)/\1/p')
code03=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?3:[ ]*\(#[0-9a-f]*\)/\1/p')
code04=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?4:[ ]*\(#[0-9a-f]*\)/\1/p')
code05=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?5:[ ]*\(#[0-9a-f]*\)/\1/p')
code06=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?6:[ ]*\(#[0-9a-f]*\)/\1/p')
code07=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?7:[ ]*\(#[0-9a-f]*\)/\1/p')
code08=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?8:[ ]*\(#[0-9a-f]*\)/\1/p')
code09=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color0\?9:[ ]*\(#[0-9a-f]*\)/\1/p')
code10=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color10:[ ]*\(#[0-9a-f]*\)/\1/p')
code11=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color11:[ ]*\(#[0-9a-f]*\)/\1/p')
code12=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color12:[ ]*\(#[0-9a-f]*\)/\1/p')
code13=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color13:[ ]*\(#[0-9a-f]*\)/\1/p')
code14=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color14:[ ]*\(#[0-9a-f]*\)/\1/p')
code15=$(xrdb -query .Xresources | tr "\t" " " | sed -ne's/^[a-zA-Z0-9]*\*\.color15:[ ]*\(#[0-9a-f]*\)/\1/p')

cat << EOF
${c00}${code00} ${c01}${code01} ${c02}${code02} ${c03}${code03} ${c04}${code04} ${c05}${code05} ${c06}${code06} ${c07}${code07}
${c00}▉▉▉▉▉▉▉ ${c01}▉▉▉▉▉▉▉ ${c02}▉▉▉▉▉▉▉ ${c03}▉▉▉▉▉▉▉ ${c04}▉▉▉▉▉▉▉ ${c05}▉▉▉▉▉▉▉ ${c06}▉▉▉▉▉▉▉ ${c07}▉▉▉▉▉▉▉
${c08}▉▉▉▉▉▉▉ ${c09}▉▉▉▉▉▉▉ ${c10}▉▉▉▉▉▉▉ ${c11}▉▉▉▉▉▉▉ ${c12}▉▉▉▉▉▉▉ ${c13}▉▉▉▉▉▉▉ ${c14}▉▉▉▉▉▉▉ ${c15}▉▉▉▉▉▉▉
${c08}${code08} ${c09}${code09} ${c10}${code10} ${c11}${code11} ${c12}${code12} ${c13}${code13} ${c14}${code14} ${c15}${code15}
EOF
