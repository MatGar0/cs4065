#!/bin/bash

# Get base path.
base_path=`sed -n "/^BASE_PATH/s/.*'\(.*\)'/\1/p" config.py`

# Install mono.
SUDO='echo 3m3mCL4b | sudo -S'
eval "$SUDO apt-get -qq update &> /dev/null"
eval "$SUDO apt-get -qq -y install mono-complete &> /dev/null"

# Download and deploy WrapRec.
cd $base_path
mkdir wraprec &> /dev/null || exit 1
cd wraprec
wget -O wraprec.tar.gz https://github.com/babakx/WrapRec/releases/download/2.0.2/wraprec.2.0.2.tar.gz &> /dev/null
[ -f wraprec.tar.gz ] &> /dev/null || exit 2
tar xzf wraprec.tar.gz &> /dev/null || exit 3
rm wraprec.tar.gz &> /dev/null

# Test WrapRec.
cd $base_path
[ -f wraprec/WrapRec.exe ] || exit 4
wraprec_output=`mono wraprec/WrapRec.exe`
[[ $wraprec_output == $'WrapRec 2.0 recommendation toolkit.'* ]] || exit 5

echo WrapRec has been deployed.
exit 0