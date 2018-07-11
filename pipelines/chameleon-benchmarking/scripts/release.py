from blazarclient import client as blazar_client
from keystoneclient import client as keystone

import os
import datetime
import logging
import time

logger = logging.getLogger(__name__)

kclient = keystone.Client(
    auth_url=os.environ["OS_AUTH_URL"],
    username=os.environ["OS_USERNAME"],
    password=os.environ["OS_PASSWORD"],
    tenant_id=os.environ["OS_TENANT_ID"])

auth = kclient.authenticate()
if auth:
    blazar_url = kclient.service_catalog.url_for(
            service_type='reservation',
            region_name=os.environ['OS_REGION_NAME'])
else:
    raise Exception("User *%s* is not authorized." %
                    os.environ["OS_USERNAME"])


bclient = blazar_client.Client(blazar_url=blazar_url,
                               auth_token=kclient.auth_token,
                               region_name=os.environ['OS_REGION_NAME'])

logger.info("Deleting lease")

leases = [lease for lease in bclient.lease.list()
          if lease['name'] == 'popper-lease']
lease = leases[0] if len(leases) > 0 else None
if lease is not None:
    bclient.lease.delete(lease['id'])
