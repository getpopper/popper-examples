# linux-cgroups

This experiment exemplifies the usage of Popper for managing changes 
and automating experiments that modify the Linux Kernel using virtual 
machines (VMs). In order to automate this process, we make use of 
[Vagrant](https://www.vagrantup.com/), a CLI tool for easily creating,
provisioning, and running virtual machines. It is an excellent choice for
certain use cases that require a high degree of customization of the runtime
environment, such as operating system research.

> For cases where this fine control is not necessary, it may be wise 
> to consider a more lightweight solution for keeping your environment 
> portable, such as Docker or a Language-specific tool such as 
> virtualenv (for Python)

This pipeline is intended to measure the performance impact of cgroups 
on a specific linux kernel version. For this, it first uses a docker 
image to compile a specified version of the kernel. After this is 
done, it provisions a vagrant box using the `.deb` packages produced 
by the last stage. It then runs a synthetic benchmark with and without 
cgroups. Finally, it takes the results from these tests and charts 
them using a jupyter notebook. We can see from this pipeline the 
advantages of splitting the our processes into discrete stages, as 
well as the power afforded by combining several tools commonly used in 
devops, taking advantage of each of their individual strengths.
