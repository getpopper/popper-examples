import cloudlab_cmd

# name of experiment to use to identify this allocation
experiment_name = 'popper-iperf'

# expiration of allocation in minutes
expiration = 180

# OS image to use
img = "urn:publicid:IDN+clemson.cloudlab.us+image+schedock-PG0:ubuntu18-docker"

# check availability and types at https://www.cloudlab.us/resinfo.php
site = 'clemson'
hw_type = 'c6320'

# create an internal network
with_lan = True

# grouping of nodes based on their experiment role
groups = {
   'server': ['server'],
   'client': ['client'],
}

# run command (parse 'apply', 'destroy', 'get-inventory' and 'renew'
cloudlab_cmd.run(experiment_name, expiration, site, groups, hw_type, img,
                 with_lan)
