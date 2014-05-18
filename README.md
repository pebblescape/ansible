# Setup

This playbook provisions and configures a Pebblescape server.  

You need ansible 1.5+

First set up your host in the hosts file:
```
[host]
localhost ansible_ssh_user=someuser
```

Then run:

```
ansible-playbook pebblescape.yml -v -i ./hosts
```

If you need to enter sude password for the user, run:

```
ansible-playbook pebblescape.yml -v -i ./hosts -K
```