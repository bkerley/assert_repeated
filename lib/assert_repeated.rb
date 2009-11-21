module AssertRepeated
  def assert_repeatedly_true(count, message=nil)
    count.times do
      result = yield
      assert(false, build_message(message, "<?> is not true", result)) unless result
    end
    # increment the count
    assert true
  end

  def assert_repeatedly_false(count, message=nil, &block)
    assert_repeatedly_true(count, message) do
      ! block.call
    end
  end

  def assert_repeatedly(count, matcher=true, message=nil)
    count.times do
      result = yield
      assert(false, build_message(message, "<?> is not true", result)) unless matcher === result
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
