
$NEWIFACE = 'eth0'
$NEWHOSTNAME = 'node1'
$NEWFQDN = 'node1.wt.local'
$NEWIP = '10.16.21.99'
$NEWGATEWAY = '10.16.21.254'
$NEWNETMASK = '255.255.255.0'
$NEWSEARCHPATH = 'wt.local'
$NEWDNS1 = '10.16.1.14'
$NEWDNS2 = '10.16.1.15'

augeas { 'ifconfig-$NEWIFACE' :
       	context => "/files/etc/network/interfaces",
        changes => [
       	        "set iface[. = '$NEWIFACE'] $NEWIFACE",
              	"set iface[. = '$NEWIFACE']/family inet",
                "set iface[. = '$NEWIFACE']/method static",
       	        "set iface[. = '$NEWIFACE']/address $NEWIP",
               	"set iface[. = '$NEWIFACE']/netmask $NEWNETMASK",
                "set iface[. = '$NEWIFACE']/gateway $NEWGATEWAY",
       	        "set iface[. = '$NEWIFACE']/dns-nameservers $NEWDNS1",
        ],
	notify => Exec['restart-networking'],
}

exec { 'restart-networking' :
	command => '/etc/init.d/networking restart',
	refreshonly => true,
}
