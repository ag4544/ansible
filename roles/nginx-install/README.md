nginx-install
=========

This role install nginx on debian-based operating system

Requirements
------------

You need any debian-based OS

Role Variables
--------------

No variables

Dependencies
------------

Role nginx-config depends on this role

Example Playbook
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
