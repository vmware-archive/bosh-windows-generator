require_relative '../generate_manifest'

describe GenerateManifest do
  input = <<-EOF
---
name: cf-guid
director_uuid: 123
instance_groups:
- name: diego_cell
  azs: [ my-az ]
  networks: [name: diego1]
  properties:
      diego:
        rep:
          bbs:
            ca_cert: BBS_CA_CERT
            client_cert: BBS_CLIENT_CERT
            client_key: BBS_CLIENT_KEY
            require_ssl: true
          zone:
            zone1
      consul:
        ca_cert: CONSUL_CA_CERT
        require_ssl: true
        agent_cert: CONSUL_AGENT_CERT
        agent_key: CONSUL_AGENT_KEY
        encrypt_keys:
          - CONSUL_ENCRYPT
        agent:
          servers:
            lan:
              - 127.0.0.1
      loggregator:
        etcd:
          machines:
            - etcd1.foo.bar
      metron_endpoint:
        shared_secret: secret123
      syslog_daemon_config:
        address: logs2.test.com
        port: 11111
update:
  serial: true
  max_in_flight: 1
EOF

  before(:each) do
    @input_file = Tempfile.new("manifest.yml")
    @input_file.write(input)
    @input_file.rewind
    @input_file.close

    @num_windows_cells = 2
  end

  after(:each) do
    @input_file.unlink
  end

 it "should generate a correct manifest" do
    generated_manifest = YAML.load(GenerateManifest.run(@input_file.path,"vsphere", @num_windows_cells))

    cells = generated_manifest['instance_groups'].select { |i| i['name'] == 'cell_windows' }
    expect(cells[0]['instances'].to_i).to eq(@num_windows_cells)
    expect(cells[0]['properties']['diego']['rep']['preloaded_rootfses']).to eq(["windows2012R2:/tmp/windows2012R2"])
    expect(cells[0]['properties']['diego']['ssl']['skip_cert_verify']).to eq(true)
    expect(cells[0]['networks'][0]['name']).to eq('windows-cells')
    expect(cells[0]['vm_type']).to eq("xlarge")
    expect(generated_manifest['stemcells'][0]['os']).to eq("windows2012R2")
  end
end
