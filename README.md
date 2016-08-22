# BOSH Windows Manifest Generator

This tool generates a Garden Windows manifest that can be deployed without any manual changes.

### Inputs

- A Cloud Foundry manifest file
    - `ssh` into the Ops Manager director and run
  
  ```
  bosh download manifest <CF_DEPLOYMENT_NAME> cf.yml
  ```
  
- IAAS to target (`aws` or `vsphere`)

### Usage

```
./generate_manifest.rb <PATH_TO_CF_MANIFEST> <IAAS_TARGET> > /tmp/garden-windows.yml
bosh -d /tmp/garden-windows.yml deploy
```

### Test

```
bundle exec rspec
```
