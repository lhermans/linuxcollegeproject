wordpress:
  pkg.installed: []
  service.running:
    - require:
      - pkg: wordpress