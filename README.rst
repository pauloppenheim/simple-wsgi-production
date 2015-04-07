simple-wsgi-production
============================================================

A simple production-ready wsgi project skeleton / template.

This involves

* `NGINX <http://nginx.org/>`_
* `gunicorn <http://gunicorn.org/>`_
* `virtualenv <https://virtualenv.pypa.io/en/latest/>`_
* `Vagrant <https://www.vagrantup.com/>`_



How do I run it?
------------------------------------------------------------

Running ``vagrant up`` from within the repo dir will download an ubuntu 14.04 VM,
start it, and run the included ``vm_bootstrap.sh`` script inside of it. Read that
script to see more of what happens.
