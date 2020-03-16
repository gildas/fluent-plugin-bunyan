# Changelog

This file contains changes throughout the life of this project.

### Development
[Full Changelog](https://github.com/gildas/fluent-plugin-bunyan/compare/v0.0.4...dev)

New Features:
* None Yet

Bug Fixes:  
* None Yet

### 0.0.4 / 2020-03-17
[Full Changelog](https://github.com/gildas/fluent-plugin-bunyan/compare/v0.0.3...v0.0.4)

Bug Fixes:
* JSON logs were not extracted properly when coming from Kubernetes

### 0.0.3 / 2020-03-15
[Full Changelog](https://github.com/gildas/fluent-plugin-bunyan/compare/v0.0.2...v0.0.3)

New Features:
* Not exactly a feature, but tests go through Azure Pipeline

Bug Fixes:
* Removed the requirement of rake version as per gem build warning
* The Fluent parser was not "required" properly besides tests passing
* License was still Apache on the README file

### 0.0.2 / 2020-03-10
[Full Changelog](https://github.com/gildas/fluent-plugin-bunyan/compare/v0.0.1...v0.0.2)

Bug Fixes:
* The GEM spec requires rake version 12.3.3 at least. 
  There is a vulnerability before rake 12.3.3: [CVE-2020-8130](https://github.com/advisories/GHSA-jppv-gw3r-w3q8).  
  We just should be on the safe side...

### 0.0.1 / 2020-03-10

Initial Release
