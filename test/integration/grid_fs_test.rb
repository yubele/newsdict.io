require 'test_helper'

class GridFsTest < ActiveSupport::TestCase
  test "Mongoid::GridFs code of oneline" do
    path = '/var/www/docker/Dockerfile'
    Mongoid::GridFs::Fs['Dockerfile'] = path
    assert Digest::SHA1.hexdigest(Mongoid::GridFs::Fs['Dockerfile'].data) == Digest::SHA1.hexdigest(File.open(path).read)
  end
end
