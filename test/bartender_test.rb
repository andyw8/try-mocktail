require_relative "../lib/bartender"
require "minitest/autorun"
require "mocktail"
require 'mocha/minitest'

class Minitest::Test
  include Mocktail::DSL

  def test_with_mocktail
    # Taken exactly from the Mocktail README:

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

  def test_with_mocha
    shaker = stub
    glass = stub
    bar = stub
    Shaker.stubs(new: shaker)
    Glass.stubs(new: glass)
    Bar.stubs(new: bar)
    glass.expects(:pour!).with(:a_drink)
    subject = Bartender.new
    shaker.stubs(:combine).with(:gin, :campari, :sweet_vermouth).returns(:a_drink)
    bar.stubs(:pass).with(glass, to: "Eileen").returns("🎉")
    result = subject.make_drink(:negroni, customer: "Eileen")

    assert_equal "🎉", result
  end

  def teardown
    Mocktail.reset()
  end
end
