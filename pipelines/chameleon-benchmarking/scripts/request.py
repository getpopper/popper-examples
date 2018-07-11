from enoslib.api import generate_inventory
from enoslib.infra.enos_chameleonbaremetal.provider import \
     Chameleonbaremetal as Cc

import logging
import os

logging.basicConfig(level=logging.INFO)


provider_conf = {
    'key_name': 'popper-key',
    'lease_name': 'popper-lease',
    'subnet': {'name': 'sharednet1-subnet'},
    'image': 'CC-Ubuntu14.04-Docker',

    'resources': {
        'machines': [{
            'role': 'compute',
            'number': 1,
            'flavor': 'compute_haswell',
            'networks': ['sharednet1', 'public']
        }],
        'networks': ['sharednet1', 'public'],

    },
}

inventory = '/enos/hosts'
provider = Cc(provider_conf)
roles, networks = provider.init()

generate_inventory(roles, networks, inventory)
