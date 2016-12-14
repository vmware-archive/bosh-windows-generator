# BOSH Windows Manifest Generator

This tool generates a Garden Windows manifest that can be deployed without any manual changes.

### Environment Prerequisites

- Create a `Service Network` in the Ops Manager web interface named `windows-cells`
- Create an `Availability Zone` in the Ops Manager web interface named `windows-cells`

### Inputs

- A Cloud Foundry manifest file
    - `ssh` into the Ops Manager VM
    - bosh login: `bosh --ca-cert <path-to-root-ca-certificate> login`
        - The Email and Password fields for the director can be found in the `Ops Manager Director`
          tile's `Credentials` tab when you log into the web interface for Ops Manager.
    - Download the CF manifest: `bosh download manifest <CF_DEPLOYMENT_NAME> cf.yml`

- IAAS to target (`aws` or `vsphere`)

### Usage

Run the following from the Ops Manager VM:

* `git clone https://github.com/pivotal-cf/bosh-windows-generator.git && cd bosh-windows-generator`

* `./generate_manifest.rb <PATH_TO_CF_MANIFEST> <IAAS_TARGET> > /tmp/garden-windows.yml`

* `bosh -d /tmp/garden-windows.yml deploy`

### Test

```
bundle exec rspec
```
