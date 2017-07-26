#!/usr/bin/env python

from subprocess import call
import os

import argparse


#Get command line options
parser = argparse.ArgumentParser(description='UPF Examples Run Script Options')

parser.add_argument('--clean', action='store_true', help='Clean LOGs..')
parser.add_argument('--gui', action='store_true', help='GUI Simulation')

args = parser.parse_args()

def create_lib():
    os.system("vlib work")
    os.system("vmap work work")

def compile_files():
    os.system("vlog -work work or_gate.v design_top.v test.sv")
    os.system("vopt -work work test -pa_upf design_top.upf -pa_top \"/test/dut_top\"  -pa_lib work -o testO -pa_enable=nonoptimizedflow")


def simulate():
    if args.gui:
        os.system("vsim work.testO -pa -do \"run -all;\"")
    else:
        os.system("vsim work.testO -pa -c -do \"run -all; exit;\"")


def clean():
    os.system("rm -r modelsim.ini transcript vsim.wlf work")


def main():

    if args.clean:
        clean()
    else:
        create_lib()
        compile_files()
        simulate()


if __name__ == '__main__':
    main()

