
A small script to import a local libvirt VM into KubeVirt.

This includes

1. Creating a OfflineVirtualMachine definition
2. Uploading the disk image from the local host to a PV

Limitations:

- Limited to a single disk (can be easily extended, PRs welcome)
- Limited to a single nic
- Subset of libvirt domain features supported

Notes:

- This is probably a subset of what `virt-v2v` can do

# Preparations

If you don't have a VM, setup a new one:

- [Download the Fedora 28 ISO](https://getfedora.org/de/workstation/download/)
- Setup a new virtual machine inside libvirt using `virt-install` or
  `virt-manager`

Setup your demo environment:

- Setup minikube as described in the demo (see link below)
- Deploy KubeVirt v0.4.1 [as described in the demo](https://github.com/kubevirt/demo)
- Download [`virtctl`](https://github.com/kubevirt/kubevirt/releases)
- Install the [kubectl PVC plugin](https://github.com/fabiand/kubectl-plugin-pvc)
- Install `xsltproc`, `xmllint`, `virsh`

# Importing the libvirt domain

Just run the provided script and use your domain as a parameter (`fedora28` in
the following example):

```bash
$ ./libvirt-to-kubevirt fedora28
offlinevirtualmachine.kubevirt.io "fedora28" created
Creating PVC
persistentvolumeclaim "fedora28-disk-1" created
Populating PVC
pod "fedora28-disk-1" created
Unable to use a TTY - input is not a terminal or the right kind of file
total 1745924
1745924 -rw-r--r--    1 root     root        1.7G May  3 13:34 disk.img
Cleanup
pod "fedora28-disk-1" deleted
$
```

That's all. The VM is imported and can be launched [as described in the demo
flow](https://github.com/kubevirt/demo#deploy-a-virtualmachine).

# Links
- KubeVirt: https://github.com/kubevirt/
- minikube demo: https://github.com/kubevirt/demo
- User guide: http://docs.kubevirt.io/
