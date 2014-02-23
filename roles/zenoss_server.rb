name "zenoss_server"
description "Configures the Zenoss monitoring server"

default_attributes(
  "zenoss" => {
    "device" => {
      "properties" => {
        "zCommandUsername" => "zenoss",
        "zKeyPath" => "/home/zenoss/.ssh/id_dsa",
        "zMySqlPassword" => "zenoss",
        "zMySqlUsername" => "zenoss"
      }
    }
  }
)

override_attributes(
  "java" => {
    "install_flavor" => "oracle",
    "jdk_version" => "7",
    "oracle" => {
      "accept_oracle_download_terms" => true
    }
  },
  "zenoss" => {
    "server" => {
      "admin_password" => "zenoss"
    },
    "core4" => {
      "rpm_url" => "http://downloads.sourceforge.net/project/zenoss/zenoss-4.2/zenoss-4.2.4/4.2.4-1897/zenoss_core-4.2.4-1897.el6.x86_64.rpm?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fzenoss%2Ffiles%2Fzenoss-4.2%2Fzenoss-4.2.4%2F4.2.4-1897%2F&ts=1392587207&use_mirror=skylink"
    },
    "device" => {
      "device_class" => "/Server/SSH/Linux"
    }
  }
)

run_list(
  "recipe[zenoss::server]"
)
