
# Assertions that run multiple times, used to smoke-test or
# randomly probe a function with a large domain.
#
# Use +assert_repeatedly_true+ or +assert_repeatedly_false+ in most cases,
# or use +assert_repeatedly+ to build your own.
module AssertRepeated
  # Check that the block returns +true+ +count+ times.
  #
  # @param [Integer] count number of times to run the block
  # @param [optional, String] message optional message to return when the assertion fails
  # @yield block that runs for the assertion; expected to evaluate to +true+
  # @raise Test::Unit::AssertionFailedError
  # @example Test encryption and decryption
  #    assert_repeatedly_true(1000) do
  #      expected = rand(100)
  #      actual = decrypt(encrypt(expected))
  #      expected == actual
  #    end
  def assert_repeatedly_true(count, message=nil, &block)
    assert_repeatedly count, true, message, &block
  end

  # Check that the block returns +false+ +count+ times.
  #
  # @param [Integer] count number of times to run the block
  # @param [optional, String] message optional message to return when the assertion fails
  # @yield block that runs for the assertion; expected to evaluate to +false+
  # @raise Test::Unit::AssertionFailedError
  # @example Test cryptographic digest function
  #    assert_repeatedly_true(1000) do
  #      expected = rand(0xFF)
  #      muted = expected ^ rand(0xFE) + 1
  #      actual = digest(expected)
  #      actual == digest(muted)
  #    end
  def assert_repeatedly_false(count, message=nil, &block)
    assert_repeatedly count, false, message, &block
  end

  # Check that the block returns +matcher+ +count+ times
  #
  # == Usage
  #
  #   assert_repeatedly(100, /awesome/) { "tests are awesome" }
  #
  # @param [Integer] count number of times to run the block
  # @param [Object] matcher what to compare against the block's result (using +#===+ )
  # @param [optional, String] message optional message to return when the assertion fails
  # @yield block that runs for the assertion; expected to be threequal to +matcher+
  # @raise Test::Unit::AssertionFailedError
  # @example Implementing assert_repeatedly_bananas
  #    def assert_repeatedly_bananas(count, &block)
  #      assert_repeatedly count, /ba(na)+$/, "Must be a plantain!", &block
  #    end
  def assert_repeatedly(count, matcher=true, message=nil)
    count.times do
      result = yield
      assert_block(build_message(message, "<?> is not ?.", result, matcher)){ false } unless matcher === result
    end
    # increment the count
    assert true
  end
end

module Test #:nodoc:
  module Unit #:nodoc:
    class TestCase #:nodoc:
      include AssertRepeated
    end
  end
end
