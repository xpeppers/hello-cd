Hello CD
========
[![Build Status](https://travis-ci.org/xpeppers/hello-cd.png?branch=master)](https://travis-ci.org/xpeppers/hello-cd)

A simple PHP project used during continuous delivery workshops.

Requirements
------------

1. [VirtualBox](https://www.virtualbox.org)
2. [Vagrant](http://www.vagrantup.com) 

Using the development VM
------------------------

    vagrant up
    vagrant ssh

Installing dependencies
-----------------------

    composer install --optimize-autoloader

Running tests
-------------

    phing test

Creating heroku app
-------------------

    heroku create --region eu --addons newrelic:standard,papertrail:choklad -a hello-cd
    heroku ps:scale web=1 -a hello-cd

