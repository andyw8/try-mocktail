require_relative "../lib/bartender"
require "minitest/autorun"
require "mocktail"

class Minitest::Test
  include Mocktail::DSL

  def test_with_mocktail
    shaker = Mocktail.of_next(Shaker)
    glass = Mocktail.of_next(Glass)
    bar = Mocktail.of_next(Bar)
    subject = Bartender.new
    stubs { shaker.combine(:gin, :campari, :sweet_vermouth) }.with { :a_drink }
    stubs { bar.pass(glass, to: "Eileen") }.with { "🎉" }

    result = subject.make_drink(:negroni, customer: "Eileen")

    assert_equal "🎉", result
    # Oh yeah, and make sure the drink got poured! Silly side effects!
    verify { glass.pour!(:a_drink) }
  end

  def teardown
    Mocktail.reset
  end
end
