snmpd:
  pkg.installed: []
  service.running:
    - require:
      - pkg:  snmpd
