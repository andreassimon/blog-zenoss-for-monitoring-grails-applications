name "grails_blue_green"
description "Provides a zero-downtime environment for Grails applications"

default_attributes()

override_attributes(
  "java" => {
    "install_flavor" => "oracle",
    "jdk_version" => "7",
    "oracle" => {
      "accept_oracle_download_terms" => true
    }
  },
  "tomcat" => {
    "keystore_password" => 'keystore_password',
    "truststore_password" => 'truststore_password',
    "java_options" => "-server -Xmx512M -XX:MaxPermSize=348M -Djava.awt.headless=true",

    "blue_server_port"  => 8005,
    "blue_http_port"    => 8080,
    "blue_https_port"   => 8080,

    "green_server_port" => 8006,
    "green_http_port"   => 8081,
    "green_https_port"  => 8081
  },
  "haproxy" => {
    "members" => [
      {
        "hostname"  => "localhost",
        "ipaddress" => "127.0.0.1",
        "port"      => 8080,
        "ssl_port"  => 8080
      }, {
        "hostname"  => "localhost",
        "ipaddress" => "127.0.0.1",
        "port"      => 8081,
        "ssl_port"  => 8081
      }
    ]
  }
)

run_list(
  "recipe[haproxy]",
  "recipe[tomcat-blue-green]",
  "recipe[tomcat-blue-green::users]",
  "recipe[haproxy-blue-green]",
  "recipe[grails]"
)
