# EasyMySQL #

[docker]: https://dev.mysql.com/downloads/workbench/

__A docker container to provide MySQL databases on the fly.__

This Dockerfile is used to provide MySQL databases in a frictionless
but flexible way. The requirement was to provide different
MySQL based relational databases for computer science students
for educational purposes (database/webtechnology lectures and labs).
Nevertheless, the approach can be used
for similar purposes in complete different domains.

Whenever you have to

- provide data as a relational database via MySQL
- with user based access requirement
- for demonstrational purposes (throw-away database)
- in an ad hoc way

this container might be of interest to you.

__Warning: You should not use this container for production purposes.__

## Prerequisites ##

First, you have to install [Docker](docker).

If you are using Linux, you are fine. You will find Docker installation instructions
for a lot of Linux distributions [here](http://docs.docker.com/installation/).

But no worries. If you are using __Windows__ (why ever) or __Mac OS X__ (like me) simply
follow the [boot2docker](http://boot2docker.io) installation instructions
for

- [Windows](https://github.com/boot2docker/windows-installer/releases) or
- [Mac OS X](https://github.com/boot2docker/osx-installer/releases)

## Usage ##

To use this container you have to build an image as a first step. This image provides a self-contained MySQL
server. You can clone this repository or tell docker to do the repository handling
behind the scenes for you (which is my preferred way in case of github provided
  Dockerfiles):

```Shell
docker build -t mysqldb github.com/axfelix/easymysql
```

This has been heavily modified from the original source forked from https://github.com/nkratzke/EasyMySQL; the master branch of this repository is  designed to be used with the Islandora Database Solution Pack. If wishing to use this standalone from the shell, get the original source.
