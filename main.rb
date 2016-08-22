#!/usr/bin/env ruby

require_relative './lib/generate_manifest'


raise(ArgumentError, 'Incorrect number of arguments provided (#{ARGV.length}),'\
  'must provide manifest file and IAAS VM type') unless ARGV.length == 2

  puts GenerateManifest.run(ARGV[0], ARGV[1]).to_yaml

