# Configure http header response using puppet
package {'nginx':
  ensure => installed,
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => '
server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;
	index index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		add_header X-Served-By $hostname;
		try_files $uri $uri/ =404;
	}
}
',
  notify  => Service['nginx'],
}

service {'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}
