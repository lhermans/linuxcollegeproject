# This block creates the wordpress database, user and sets user access. 
wordpress_db:
 mysql_database.present:
  - name: wordpress
 mysql_user.present:
  - name: wordpress
  - password: wpassword
 mysql_grants.present:
  - database: wordpress.*
  - grant: ALL PRIVILEGES
  - user: wordpress
  - host: '%'
  - query: |
       FLUSH PRIVILEGES;

    
#Installs other dependancies
php-curl:
 pkg:
  - installed
php-gd:
 pkg:
  - installed
php-mbstring:
 pkg:
  - installed 
php-mcrypt:
 pkg:
  - installed
php-xml:
 pkg:
  - installed
php-xmlrpc:
 pkg:
  - installed

apache2:
  service.running:
    - enable: True
    - reload: True

#Download WP
get_wordpress:
 cmd.run:
  - name: 'wget http://wordpress.org/latest.tar.gz && tar xvzf latest.tar.gz'
- cwd: /tmp

#Set ownership of WP dir to current user
/var/www/html:
  file.directory:
    - user: ubuntu
    - group: ubuntu
    - mode: 777 # some permission    
    - recurse:
      - user
      - group
