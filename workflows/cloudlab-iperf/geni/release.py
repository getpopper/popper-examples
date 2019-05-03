import os

from geni.aggregate import cloudlab
from geni import util


ctx = util.loadContext(key_passphrase=os.environ['GENI_KEY_PASSPHRASE'])


print("Available slices: {}".format(ctx.cf.listSlices(ctx).keys()))

if util.sliceExists(ctx, 'popper-examples'):
    print('Slice exists.')
    print('Removing sliver (errors are ignored)')
    util.deleteSliverExists(cloudlab.Clemson, ctx, 'popper-examples')
else:
    print("Slice does not exist.")
