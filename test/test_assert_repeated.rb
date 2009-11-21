require 'helper'

class TestAssertRepeated < Test::Unit::TestCase
  def test_one_passing
    assert_nothing_raised do
      assert_repeatedly_true(1){ true }
    end
  end

  def test_one_failure
    assert_raise Test::Unit::AssertionFailedError do
      assert_repeatedly_true(1){ false }
    end
  end

  def test_a_hundred_passings
    count = 0
    assert_repeatedly_true 100 do
      count = count + 1
      true
    end

    assert_equal 100, count
  end

  def test_first_failure
    count = 0
    assert_raise Test::Unit::AssertionFailedError do
      assert_repeatedly_true 100 do
        count = count + 1
        false
      end
    end

    assert_equal 1, count
  end

  def test_one_negative
    assert_nothing_raised do
      assert_repeatedly_false(1){ false }
    end
  end

  def test_assert_repeatedly_base
    assert_nothing_raised do
      assert_repeatedly(1, 7) { 7 }
      assert_repeatedly(1, /x/) { 'x' }
    end

    assert_raise Test::Unit::AssertionFailedError do
      assert_repeatedly(1, 7) { 8 }
      assert_repeatedly(1, /x/) { 'f' }
    end
  end
end
