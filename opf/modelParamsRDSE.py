#!/usr/bin/env python

import modelParams as mp
MODEL_PARAMS = mp.MODEL_PARAMS

# Override with the changes:
MODEL_PARAMS['modelParams']['sensorParams']['encoders'] = {
                u'function':    {
                    'fieldname': u'function',
                    'n': 1000,
                    'name': u'function',
                    'resolution': 0.05,
                    'type': 'RandomDistributedScalarEncoder',
                    'w': 21,
                    'offset': 0,
                },
           }
