#!/usr/bin/env python
import os.path
import geni.cloudlab_util as cl
from geni.rspec import pg as rspec

if not os.path.isdir('/output'):
    raise Exception("expecting '/output folder'")

img = "urn:publicid:IDN+clemson.cloudlab.us+image+schedock-PG0:docker-ubuntu16"

requests = {}


def create_request(_site, hw_type, num_nodes):
    for i in range(0, num_nodes):
        node = rspec.RawPC('node' + str(i))
        node.disk_image = img
        node.hardware_type = hw_type
        if _site not in requests:
            requests[_site] = rspec.Request()
        requests[_site].addResource(node)

create_request('apt', 'r320', 1)
create_request('apt', 'r720', 1)
create_request('apt', 'c6220', 1)

create_request('cl-clemson', 'c6320', 1)
create_request('cl-clemson', 'c6420', 1)
create_request('cl-clemson', 'c8220', 1)
create_request('cl-clemson', 'dss7500', 1)

# create_request('cl-utah', 'm400') # ARM machine
create_request('cl-utah', 'm510', 1)
# create_request('cl-utah', 'xl170')

create_request('cl-wisconsin', 'c220g1', 1)
create_request('cl-wisconsin', 'c220g2', 1)
create_request('cl-wisconsin', 'c240g1', 1)
create_request('cl-wisconsin', 'c240g2', 1)

create_request('ig-utahddc', 'dl360', 1)

create_request('pg-utah', 'd430', 1)
create_request('pg-utah', 'd710', 1)
create_request('pg-utah', 'd820', 1)

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
