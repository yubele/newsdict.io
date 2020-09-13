require 'test_helper'
class BatchTest < ActiveSupport::TestCase
  test 'single' do
    sum = 0
    threads = []
    100.times do
      threads << Thread.new{ Batch.onetime(:batch_test) { sum = sum + 1 } }
    end
    ThreadsWait.all_waits(*threads)
    threads.each { |thread| thread.join }
    assert_equal sum, 1
  end
end