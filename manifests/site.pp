$readablemac = regsubst($macaddress, ':', '', 'G')

node 'aron-desktop-ubuntu' {
	include aron-nginx

	$site_name = 'arontest.com'
	$site_domain = 'arontest.com'

	file { '/etc/nginx/sites-enabled/arontest.com.conf':
		content => template('aron-nginx/vhost.conf.erb'),
		notify => Service['nginx'],
	}

	file { '/usr/share/nginx/www/arontest.com':
		ensure => directory,
	}

	file { '/usr/share/nginx/www/arontest.com/index.html':
		source => 'puppet:///modules/arontest/index.html',
		require => File['/usr/share/nginx/www/arontest.com'],
	}

	include aron-mysql

	file { '/etc/mysql/my.cnf':
		content => template('aron-mysql/my.cnf.erb'),
		notify => Service['mysql'],
	}


}
