#!/usr/bin/env ruby -
require "pathname"

require 'openssl'
root = Pathname.new(__dir__)
key_file = root.join( "../", "../", "../", "../", "config", "certs", "localhost.key")
cert_file = root.join("../", "../", "../", "../", "config", "certs", "localhost.cert")
unless File.exist?(File.join(__dir__, "../", "../", "../", "../", "config", "certs", "localhost.key"))
    root_key = OpenSSL::PKey::RSA.new(2048)
    key_file.write(root_key)

    root_cert = OpenSSL::X509::Certificate.new.tap do |root_ca|
      root_ca.version = 2 # cf. RFC 5280 - to make it a "v3" certificate
      root_ca.serial = 0x0
      root_ca.subject = OpenSSL::X509::Name.parse "/C=BE/O=A1/OU=A/CN=localhost"
      root_ca.issuer = root_ca.subject # root CA"s are "self-signed"
      root_ca.public_key = root_key.public_key
      root_ca.not_before = Time.now
      root_ca.not_after = root_ca.not_before + 2 * 365 * 24 * 60 * 60 # 2 years validity
      root_ca.sign(root_key, OpenSSL::Digest::SHA256.new)
    end
    cert_file.write(root_cert)
end