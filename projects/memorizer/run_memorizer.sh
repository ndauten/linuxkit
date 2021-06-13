#!/bin/bash
# NOTE: You must pass initrd as param to qemu to run the kernel!
# $1: path to vmlinuz

BASEDIR=$(dirname "$BASH_SOURCE")
NETOPTS="-net nic,model=virtio,macaddr=52:54:00:12:34:56 -net user,hostfwd=tcp:127.0.0.1:5556-:22"
FILEOPTS="id=fs1,security_model=none -device virtio-9p-pci,fsdev=fs1,mount_tag=host-code"
GENOPTS="--enable-kvm -m 100G $NETOPTS $FILEOPTS "

qemu-system-x86_64 $GENOPTS \
    -kernel memorizer-kernel \
    -initrd ~/rootfs.cpio.gz \
    -append 'root=/dev/vda1 console=hvc0 nokaslr memalloc_size=10' \
    -chardev stdio,id=stdio,mux=on,signal=off \
    -device virtio-serial-pci \
    -device virtconsole,chardev=stdio \
    -mon chardev=stdio \
    -display none \
    
