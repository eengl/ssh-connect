# ssh-connect

## Introduction

`connect.bash` is a shell script wrapper for SSH connections. It provides an in-terminal menu of connection choices that can be added by the user.  The script has the ability to perform SSH tunneling (upon first connection to a given host).  Succeeding connections to a host will then use the tunnel established in the first connection.

Connection options are stored in a config file `~/.sshconnectrc` that has the following format:

```
n:"title":loginname:hostname:tunnelhostname:localport:
```
n = Connection number (ex. 1)

title = Connection menu title (ex. "Server A")

loginname = Remote login name (ex. John.Smith)

hostname = Hostname of remote system (ex. servera.com)

tunnelhostname = Hostname in which to establish a tunnel (ex. servera.com)

localport = Local port number for SSH tunnel (ex. 45678)

## Supported Operating Systems

* Linux/macOS/UNIX with Bash and SSH

## Software Dependencies

* bash 
* openssh

## Installation Instructions

* Clone or download `ssh-connect` package
* Copy `connect.bash` to ~/bin or another directory that is in your $PATH
* [OPTIONAL] Create symlink: `ln -s connect.bash connect`

## Usage

`connect.bash` will...
