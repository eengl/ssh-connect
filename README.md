# ssh-connect

## Introduction

`connect.bash` is a shell script wrapper for SSH connections. It provides an in-terminal menu of connection choices that can be added by the user.  The script has the ability to perform SSH tunneling (upon first connection to a given host).  Succeeding connections to a host will then use the tunnel established in the first connection.

Connection options are stored in a comma-delimited config file `~/.sshconnectrc` that has the following format:

```
n:"title":loginname:hostname:tunnelhostname:localport:
```
n = Connection number (ex. 1)

title = Connection menu title (ex. "Server A")

loginname = Remote login name (ex. John.Smith)

hostname = Hostname of remote system (ex. servera.com)

tunnelhostname = Hostname in which to establish a tunnel (ex. servera.com)

localport = Local port number for SSH tunnel (ex. 45678)

__NOTE:__ SSH access to some remote systems require a bastion host login then the user is redirected to a host of their choice.  In these situations, `hostname` would be the bastion host and `tunnelhostname` would be a destination host.

## Supported Operating Systems

* Linux, macOS, or UNIX with Bash and SSH

## Software Dependencies

* bash 
* openssh

## Installation Instructions

* Clone or download `ssh-connect` package
* Copy `connect.bash` to ~/bin or another directory that is in your $PATH
* Create symlink: `ln -s connect.bash connect` __[OPTIONAL]__

## Usage

`connect.bash` or `connect` (if you use a symlink) will present the user with a menu in which the user selects the connection option by entering the connection number.

```
$ connect
...
****************************
*   SELECT HOST COMPUTER   *
*          ****            *
*  1) Server A             *
*  2) Server B             *
*                          *
*  A) Add Entry            *
****************************
Select option:
```
