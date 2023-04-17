#!/bin/bash

OBJDUMP=riscv64-unknown-linux-gnu-objdump

bold=$(tput bold)
red=$(tput setaf 1)
green=$(tput setaf 2)
normal=$(tput sgr0)

print_green() {
    # $1: binary name
    # $2: target instruction
    # $3: instruction count
    echo "Binary $1 has ${bold}${green}$3${normal} $2 instruction"
}

print_red() {
    # $1: binary name
    # $2: target instruction
    # $3: instruction count
    echo "Binary $1 has ${bold}${red}$3${normal} $2 instruction"
}

verify_inst() {
    # $1: binary name
    # $2: target instruction
    # $3: expected
    count=$($OBJDUMP -D -j .text  $1 | grep -i $2 | wc -l)
    if [ "$count" -gt  "0" ]; then
        print_green $1 $2 $count
    else
        print_red $1 $2 $count
    fi
}

echo "**Each of the tests below should produce at least 1 desired vector instruction.**"
verify_inst bin/gather.rvv vsetvl
verify_inst bin/gather.rvv vle64
verify_inst bin/gather.rvv vluxei64
verify_inst bin/gather.rvv vse64

verify_inst bin/scatter.rvv vsetvl
verify_inst bin/scatter.rvv vle64
verify_inst bin/scatter.rvv vsuxei64
verify_inst bin/scatter.rvv vse64

verify_inst bin/stream.rvv vsetvl
verify_inst bin/stream.rvv vle64
verify_inst bin/stream.rvv vse64
verify_inst bin/stream.rvv vfmul
verify_inst bin/stream.rvv vfadd
verify_inst bin/stream.rvv vfmadd

verify_inst bin/vadd.rvv vsetvl
verify_inst bin/vadd.rvv vle64
verify_inst bin/vadd.rvv vmv
verify_inst bin/vadd.rvv vredsum

verify_inst bin/vector_sum.rvv vsetvl
verify_inst bin/vector_sum.rvv vle32
verify_inst bin/vector_sum.rvv vfmv
verify_inst bin/vector_sum.rvv vfredosum
