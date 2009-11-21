module AssertRepeated
  def assert_repeatedly_true(count)
    count.times do
      result = yield
      assert_block("#{result} is not true"){ false } unless result
    end
    assert_block{ true }
  end
end

module Test
  module Unit
    class TestCase
      include AssertRepeated
    end
  end
end
