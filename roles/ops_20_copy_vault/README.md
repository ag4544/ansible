ops_20_copy_vault
=========

This role copies some encrypted file to

Requirements
------------

You need any debian-based OS

Role Variables
--------------

No variables

Dependencies
------------

This role depends on ops_20_nginx_install

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
---
- name: Install nginx and copy config and encrypted files
  hosts: all

  roles:
    - ops_20_copy_vault
```

License
-------

BSD

Author Information
------------------
ag4544@yandex.ru
