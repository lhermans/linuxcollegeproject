mysql-server:
  pkg.installed: []
  service.running:
    - require:
      - pkg:  mysql-server