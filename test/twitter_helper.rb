require 'webmock'
include WebMock::API

WebMock.enable!

[:get, :post, :put, :delete].each do |type|
  method_name = "stub_#{type}"
  Object.send(:define_method, method_name) do |path|
    stub_request(type, "#{Twitter::REST::Request::BASE_URL}#{path}")
  end
end

[:get, :post, :put, :delete].each do |type|
  name = "standard_stub_#{type}"
  Object.send(:define_method, name) do |path|
    stub_request(type, path)
  end
end

def stub(type, api_uri, fixture_path, query = {}, query_type = :get)
  if type == :twitter
    method_name = "stub_#{query_type}"
  else
    method_name = "standard_stub_#{query_type}"
  end
  Object.send(method_name, api_uri)
    .with(query: query)
    .to_return(body: fixture(fixture_path), headers: {content_type: 'application/json; charset=utf-8'})
end

# Change path `fixtures` to `fixtures/web_mock/twitter`
def fixture_path
  File.expand_path('fixtures/', __dir__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def capture_warning
  begin
    old_stderr = $stderr
    $stderr = StringIO.new
    yield
    result = $stderr.string
  ensure
    $stderr = old_stderr
  end
  result
end