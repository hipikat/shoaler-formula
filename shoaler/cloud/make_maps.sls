#!stateconf -o yaml .  mako
#
# Generate cloud maps used to deploy VMs in parallel with salt-cloud
########################################################################

<%namespace name="helpers" file="salt://chippery/helpers.sls" />
<%
chippery = helpers.attr.ChipperySetup(pillar)


from functools import partial
from pprint import pprint
with open('/tmp/chippery-dev.txt', 'w+') as dumblog_f:
  dumblog = partial(pprint, stream=dumblog_f)
  dumblog(chippery.salt_cloud_map())


import yaml
fake_map = yaml.load('''
fedora_small:
    - web1:
        minion:
            log_level: debug
            grains:
                cheese: tasty
                omelet: du fromage
    - web2:
        minion:
            log_level: warn
            grains:
                cheese: more tasty
                omelet: with peppers
''')

%>




# Try with an accumulator...
.Cloud map file for Chippery minions:
  file.managed:
    - name: /etc/salt/chippery.cloud-map
    - source: salt://chippery/templates/cloud-map.mako
    - template: mako
    - context:
        last_updated: whenever
        cloud_map: ${chippery.salt_cloud_map()}
