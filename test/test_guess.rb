require File.expand_path(File.dirname(__FILE__) + '/helper')

class TestGuess < Test::Unit::TestCase


  def setup
    Guess.delete
  end

  def test_guess_should_require_name
    g = valid_guess(:name => nil)
    assert !g.valid?
  end

  def test_guess_should_validate_ounces
    g = valid_guess(:ounces => "string")
    assert !g.valid?
    g = valid_guess(:ounces => -1)
    assert !g.valid?
    g = valid_guess(:ounces => 0)
    assert g.valid?
    g = valid_guess(:ounces => 15)
    assert g.valid?
    g = valid_guess(:ounces => 16)
    assert !g.valid?
  end

  def test_should_validate_pounds
    g = valid_guess(:pounds => "stuff")
    assert !g.valid?
    g = valid_guess(:pounds => -2)
    assert !g.valid?
  end

  private

  def valid_guess(params = {})
    Guess.new(  {:name => "Jacob Dunphy",
                :ounces => 5,
                :pounds => 8}.merge(params))
  end
end
