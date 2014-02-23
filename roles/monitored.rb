name "monitored"
description "Bundles settings for nodes monitored by Zenoss"

default_attributes()

override_attributes(
  "snmp" => {
    "snmpd" => {
      "snmpd_opts" => '-Lsd -Lf /dev/null -u snmp -g snmp -I -smux -p /var/run/snmpd.pid'
    },
    "full_systemview" => true,
    "include_all_disks" => true
  }
)

run_list(
  "recipe[snmp]"
)
