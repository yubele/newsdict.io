require 'test_helper'

class CollectTagTest < ActiveSupport::TestCase
  test "add" do
    CollectTag.add('tag_test1')
    assert_equal CollectTag.find_by(name: 'tag_test1').count, 1
    CollectTag.add('tag_test1')
    assert_equal CollectTag.find_by(name: 'tag_test1').count, 2
    CollectTag.add('tag_test2')
    assert_equal CollectTag.find_by(name: 'tag_test1').count, 2
    CollectTag.add('tag_test2')
    assert_equal CollectTag.find_by(name: 'tag_test2').count, 2
    assert_equal CollectTag.all.count, 2
  end
end
