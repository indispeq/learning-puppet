class aron-mysql {
	$password = 'asdfasdfjkl123'

	package { 'mysql-server':
		ensure => installed,
	}

	service { 'mysql':
		ensure => running,
		enable => true,
		require => Package['mysql-server']
	}

	exec { 'Set MySQL server root password':
    		subscribe => Package['mysql-server'],
		refreshonly => true,
		unless => 'mysqladmin -uroot -p$password status',
		path => '/bin:/usr/bin',
		command => 'mysqladmin -uroot password $password',
  }

}
