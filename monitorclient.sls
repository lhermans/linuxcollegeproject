snmpd:
  pkg.installed: []
  service.running:
    - require:
      - pkg:  snmpd
	- reload: True
