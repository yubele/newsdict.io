guard :shell do
  # Generate documents from asciidoc
  watch(%r{^src/doc/(.*).adoc$}) do |m|
    `bash src/provisioning/startup/asciidoctor/update.sh #{m[0]} doc/#{m[1]}`
  end
  watch(%r{^src/doc/(.*)\.(png|jpeg|jpg|gif)$}) do |m|
    `mkdir -p $(dirname #{m[1]})`
    `cp #{m[0]} doc/#{m[1]}.#{m[2]}`
  end
  watch(%r{^(app|db)/.+\.rb$}) do |m|
    `bash src/provisioning/startup/guard/yard.sh development`
  end
  watch(%r{^README.adoc$}) do |m|
    `bash src/provisioning/startup/asciidoctor/update.sh src/doc/index.adoc doc/index`
    `bash src/provisioning/startup/asciidoctor/revealjs.sh README.adoc`
  end
  watch(%r{^presentation.ja.adoc$}) do |m|
    `bash src/provisioning/startup/asciidoctor/revealjs.sh presentation.ja.adoc`
  end
end