nginx-config
=========

This role imakes basic configuration of nginx on debian-based operating system

Requirements
------------

You need any debian-based OS

Role Variables
--------------

sendfile:
tcp_nopush:
tcp_nodelay:
keepalive_timeout:
listen_port:
rootdir:
destinationsite:

Dependencies
------------

nginx-install


----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
---
- name: Install nginx and make basic configuration
  hosts: all

  roles:
    - nginx-config
```

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
