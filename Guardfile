# Generate documents from asciidoc
require 'asciidoctor'
require 'asciidoctor-diagram'

guard 'shell' do
  watch(/^src\/(doc\/.*)\.adoc$/) do |m|
    `bundle exec asciidoctor -r asciidoctor-diagram #{Dir.pwd}/#{m[0]} -o #{Dir.pwd}/#{m[1]}.html`
  end
end

# Generate documents from yard
guard 'yard', :server => false do
  watch(%r{^.+\.rb$})
  watch(%r{^.+\.md$})
end