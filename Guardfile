# Generate documents from asciidoc
guard 'shell' do
  watch(/^src\/(doc\/asciidoc\/.*)\.adoc$/) do |m|
    `bundle exec asciidoctor -r asciidoctor-diagram #{Dir.pwd}/#{m[0]} -o #{Dir.pwd}/#{m[1]}.html`
  end
end

# Generate Yard Graph
guard 'shell' do
  watch(/(\.rb|\.md|src\/doc\/index\.adoc)$/) do |m|
    src = "src/doc/index.adoc"
    tmp_src = "src/doc/index.tmp.adoc"
    `bundle exec yardoc`
    `cp #{src} #{tmp_src}`
    `echo "" >> #{Dir.pwd}/#{tmp_src}`
    `echo "[graphviz, source-graph, svg]" >> #{Dir.pwd}/#{tmp_src}`
    `echo "--------" >> #{Dir.pwd}/#{tmp_src}`
    `bundle exec yard graph --full >> #{Dir.pwd}/#{tmp_src}`
    `echo "--------" >> #{Dir.pwd}/#{tmp_src}`
    `echo "link:/source-graph.svg[Expansion Image]" >> #{Dir.pwd}/#{tmp_src}`
    `bundle exec asciidoctor -r asciidoctor-diagram #{Dir.pwd}/#{tmp_src} -o #{Dir.pwd}/doc/index.html`
  end
end