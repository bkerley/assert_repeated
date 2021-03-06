require 'helper'

class TestAssertRepeated < Test::Unit::TestCase
  def test_repeatedly_true
    count = 0
    assert_nothing_raised do
      assert_repeatedly_true 100 do
        count = count + 1
        true
      end
    end

    assert_equal 100, count

    count = 0

    assert_assertion_failure_raised_with_message "<false> is not true." do
      assert_repeatedly_true 100 do
        count = count + 1
        false
      end
    end

    assert_equal 1, count
  end

  def test_repeatedly_false
    count = 0
    assert_nothing_raised do
      assert_repeatedly_false 100 do
        count = count + 1
        false
      end
    end

    assert_equal 100, count

    count = 0

    assert_assertion_failure_raised_with_message "<true> is not false." do
      assert_repeatedly_false 100 do
        count = count + 1
        true
      end
    end

    assert_equal 1, count
  end

  def test_assert_repeatedly_base
    assert_nothing_raised do
      assert_repeatedly(1, 7) { 7 }
      assert_repeatedly(1, /x/) { 'x' }
    end

    assert_assertion_failure_raised_with_message "<8> is not 7." do
      assert_repeatedly(1, 7) { 8 }
    end

    assert_assertion_failure_raised_with_message "<\"f\"> is not /x/." do
      assert_repeatedly(1, /x/) { 'f' }
    end
  end

  private
  # bonus secret assertion
  def assert_assertion_failure_raised_with_message(message)
    begin
      yield
      assert false, "No exception raised"
    rescue Test::Unit::AssertionFailedError => e
      assert_equal message, e.message
    rescue Exception => e
      assert false, "Unexpected exception <e> raised"
    end
  end
end
