# Vagrant support
```
cd vagrant
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-vbguest
vagrant up
```

When finished, use a HTTP/REST client like Postman to verify the fingerprint and recorgnize endpoints :
```
curl -F ‘data=@dejavu/mp3/Brad-Sucks--Total-Breakdown.mp3’ http://localhost:8080/fingerprint

# Fingerprint require few minutes to finish
curl -F ‘data=@dejavu/mp3/Brad-Sucks--Total-Breakdown-trimmed.mp3’ http://localhost:8080/recorgnize
```


In case you're getting the error below when running the vm, please
```
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attempted was:

mount -t vboxsf -o uid=1000,gid=1000 data_library /data/library

The error output from the command was:

/sbin/mount.vboxsf: mounting failed with the error: No such device
```

```
$ sudo yum update
$ sudo yum install kernel-$(uname -r) kernel-devel kernel-headers # or: reinstall
$ rpm -qf /lib/modules/$(uname -r)/build
kernel-2.6.32-573.18.1.el6.x86_64
$ ls -la /lib/modules/$(uname -r)/build
$ sudo reboot # and re-login
$ sudo ln -sv /usr/src/kernels/$(uname -r) /lib/modules/$(uname -r)/build
$ sudo /opt/VBoxGuestAdditions-*/init/vboxadd setup
```
