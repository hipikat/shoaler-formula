#
# Orchestrate the provisioning and highstate of minions and projects
########################################################################

Generate cloud maps:
  salt.state:
    - tgt: '*'
    - sls:
      - chippery.cloud.make_maps
