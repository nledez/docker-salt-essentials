Why
===
For test examples for "Salt Essentials" book:
http://shop.oreilly.com/product/0636920033240.do

First steps
===========
MY_DOCKER="your-docker-machine" # Found with a "docker-machine ls"

```
# Load docker-machine-environment
eval "$(docker-machine env ${MY_DOCKER})"
# Update apt-cacher config file for containers
docker-machine inspect ${MY_DOCKER} | python -c 'import sys, json; print "Acquire::http::Proxy \"http://{}:3142/\";".format(json.load(sys.stdin)["Driver"]["IPAddress"])' > debian-patch/etc/apt/apt.conf.d/02proxy
# Check the config file
cat debian-patch/etc/apt/apt.conf.d/02proxy

# Launch containers
docker-compose up -d

# Connect on master
docker exec --detach=false --interactive=true --tty=true dockersaltessentials_salt-master_1 /bin/bash

# Connect on minion
docker exec --detach=false --interactive=true --tty=true dockersaltessentials_salt-minion_1 /bin/bash

# Create others minion
docker-compose scale salt-minion=4
```

Rebuild master and restart it
=============================
```
docker-compose build salt-master ; docker-compose up -d salt-master ; docker-compose up -d salt-minion ; docker exec --detach=false --interactive=true --tty=true dockersaltessentials_salt-master_1 /bin/bash
```

Relaunch minions after master update and/or restart
===================================================
```
docker-compose kill salt-minion ; docker-compose rm salt-minion ; docker-compose up -d salt-minion ; docker-compose scale salt-minion=4 ; docker exec --detach=false --interactive=true --tty=true dockersaltessentials_salt-minion_1 /bin/bash
```


Differences with book
=====================

Containers are only with Ubuntu

The saltmaster auto-accept minions
```
salt-patch/etc/salt/master.d/auto-accept.conf
```

For Custom Grains on page 99 the hostname does'nt match, use minion_id instead
```
salt-srv/salt/file/base/_grains/my_grains.py:    # hostname = platform.node()
salt-srv/salt/file/base/_grains/my_grains.py:    hostname = __opts__.get('id', '')
```
