# Generate documents from asciidoc
guard 'shell' do
  watch(%r{^src/doc/(.*).adoc$}) do |m|
    `sh src/provisioning/startup/asciidoctor/update.sh #{m[0]} doc/#{m[1]}`
  end
  watch(%r{^README.adoc$}) do |m|
    `sh src/provisioning/startup/asciidoctor/update.sh src/doc/index.adoc doc/index`
  end
end