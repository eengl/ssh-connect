# ssh-connect

## Introduction

Bash shell script wrapper for connecting to NOAA/NCEP's VPN. The script uses `openconnect`, an open source Cisco AnyConnect SSL VPN compatible client. Normally, establishing a VPN connection via `openconnect` requires the user to have sudo access. This package will also install sudoer rules to allow the user to run `ncepvpn` and `openconnect` without sudo access.

## Supported Operating Systems

The following 64-bit Linux operating systems have been tested

* CentOS 6.x, 7.x
* RHEL 6.x, 7.x
* Fedora 24, 25
* Ubuntu 14.04 LTS, 16.04 LTS

## Software Dependencies

* openssh

## Installation Instructions

* Clone or download `ssh-connect` package
* Copy `connect.bash` to ~/bin or another directory that is in your $PATH
* [OPTIONAL] Create symlink: `ln -s connect.bash connect`

## Usage

`connect.bash` will...
