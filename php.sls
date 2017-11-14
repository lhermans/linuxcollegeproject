php-mysql:
  pkg.installed: []
  service.running:
    - require:
      - pkg:  php-mysql
