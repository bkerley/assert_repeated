module AssertRepeated
  # Assertions that run multiple times, used to smoke-test or
  # randomly probe a function with a large domain.
  #
  # == Usage
  #
  #    assert_repeatedly_true(1000) do
  #      expected = rand(100)
  #      actual = decrypt(encrypt(expected))
  #      expected == actual
  #    end

  # Check that the block returns +true+ +count+ times.
  #
  # == Arguments
  # [+count+] number of times to run the block
  # [+message+] optional message to return when the assertion fails
  # [+block+] block that runs for the assertion; expected to evaluate to +true+
  def assert_repeatedly_true(count, message=nil, &block)
    assert_repeatedly count, true, message, &block
  end

  # Check that the block returns +false+ +count+ times.
  #
  # == Arguments
  # [+count+] number of times to run the block
  # [+message+] optional message to return when the assertion fails
  # [+block+] block that runs for the assertion; expected to evaluate to +false+
  def assert_repeatedly_false(count, message=nil, &block)
    assert_repeatedly count, false, message, &block
  end

  # Check that the block returns +matcher+ +count+ times
  #
  # == Usage
  #
  #   assert_repeatedly(100, /awesome/) { "tests are awesome" }
  #
  # == Arguments
  # [+count+] number of times to run the block
  # [+matcher+] what to compare against the block's result (using +#===+ )
  # [+message+] optional message to return when the assertion fails
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
