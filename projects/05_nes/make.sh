#!/bin/sh

iverilog -g2005-sv -DICARUS=1 -o main.qqq main.v ppu.v cpu.v
vvp main.qqq >> /dev/null

# gtkwave nes.vcd

echo 'OK'
