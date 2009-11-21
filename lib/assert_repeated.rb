module AssertRepeated
  def assert_repeatedly_true(count, message=nil, &block)
    assert_repeatedly count, true, message, &block
  end

  def assert_repeatedly_false(count, message=nil, &block)
    assert_repeatedly count, false, message, &block
  end

  def assert_repeatedly(count, matcher=true, message=nil)
    count.times do
      result = yield
      assert_block(build_message(message, "<?> is not ?.", result, matcher)){ false } unless matcher === result
    end
    # increment the count
    assert true
  end
end

module Test
  module Unit
    class TestCase
      include AssertRepeated
    end
  end
end
