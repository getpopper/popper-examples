#!/usr/bin/env python
import os.path
import geni.cloudlab_util as cl
from geni.rspec import pg as rspec

if not os.path.isdir('/output'):
    raise Exception("expecting '/output folder'")

img = "urn:publicid:IDN+apt.emulab.net+image+schedock-PG0:docker-ubuntu16:0"

requests = {}


def create_request(_site, hw_type, num_nodes):
    for i in range(0, num_nodes):
        node = rspec.RawPC('node' + str(i))
        node.disk_image = img
        node.hardware_type = hw_type
        if _site not in requests:
            requests[_site] = rspec.Request()
        requests[_site].addResource(node)


create_request('cl-clemson', 'c6320', 1)

print("Executing cloudlab request")
manifests = cl.request(
    experiment_name=('clapp-' + os.environ['CLOUDLAB_USER']),
    requests=requests, timeout=30, expiration=1200,
    ignore_failed_slivers=True)

print("Writing /output/machines file")
with open('/output/machines', 'w') as f:
    for site, manifest in manifests.iteritems():
        for n in manifest.nodes:
            f.write(n.hostfqdn)
            f.write(' ansible_user=' + os.environ['CLOUDLAB_USER'])
            f.write(' ansible_become=true' + os.linesep)

        with open('/output/{}.xml'.format(site), 'w') as mf:
            mf.write(manifest.text)
