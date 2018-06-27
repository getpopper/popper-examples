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


create_request('cl-clemson', 'c6320', 1)

# if one or more nodes of another type are needed, the above line can be
# executed with a distinct hardware type. Many invocations are supported (i.e.
# create an allocation of multiple hardware types). Available ones are:
#
#   'apt', 'r320'
#   'apt', 'r720'
#   'apt', 'c6220'
#   'cl-clemson', 'c6320'
#   'cl-clemson', 'c6420'
#   'cl-clemson', 'c8220'
#   'cl-clemson', 'dss7500'
#   'cl-utah', 'm400' # ARM machine
#   'cl-utah', 'm510'
#   'cl-utah', 'xl170'
#   'cl-wisconsin', 'c220g1'
#   'cl-wisconsin', 'c220g2'
#   'cl-wisconsin', 'c240g1'
#   'cl-wisconsin', 'c240g2'
#   'ig-utahddc', 'dl360'
#   'pg-utah', 'd430'
#   'pg-utah', 'd710'
#   'pg-utah', 'd820'
#   'pg-kentucky', 'pc3000'

print("Executing cloudlab request")
manifests = cl.request(
    experiment_name=('clb-' + os.environ['CLOUDLAB_USER']),
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
