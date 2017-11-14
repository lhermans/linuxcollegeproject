syslog-ng-core:
  pkg.installed: []
  service.running:
    - require:
      - pkg: syslog-ng-core

deploy the syslog-ng.conf file:
  file.managed:
    - name: /etc/syslog-ng/syslog-ng.conf
    - source: salt://syslog-ng.conf