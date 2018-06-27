#!/usr/bin/env python
import os
import geni.cloudlab_util as cl
cl.renew(experiment_name=('clb-'+os.environ['CLOUDLAB_USER']),
         expiration=1200)
