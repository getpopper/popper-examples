import os

from geni.aggregate import cloudlab
from geni.rspec import pg
from geni import util


def baremetal_node(name, img, hardware_type):
    node = pg.RawPC(name)
    node.disk_image = img
    node.hardware_type = hardware_type
    return node


experiment_name = 'popper-examples'
img = "urn:publicid:IDN+clemson.cloudlab.us+image+schedock-PG0:ubuntu18-docker"

request = pg.Request()
request.addResource(baremetal_node("client", img, 'c6320'))
request.addResource(baremetal_node("server", img, 'c6320'))

# load context
ctx = util.loadContext(key_passphrase=os.environ['GENI_KEY_PASSPHRASE'])

# create slice
util.createSlice(ctx, experiment_name, renew_if_exists=True)

# create sliver on clemson
manifest = util.createSliver(ctx, cloudlab.Clemson, experiment_name, request)

manifest = cloudlab.Clemson.listresources(ctx, experiment_name)

# output files
# {

# write to folder that holds this script
outdir = os.path.dirname(os.path.realpath(__file__))
util.toAnsibleInventory(manifest, hostsfile=outdir+'/hosts')
manifest.writeXML('{}/manifest.xml'.format(outdir))
# }
