class Shaker
  def combine(*ingredients)
  end
end

class Glass
  def pour!(drink)
  end
end

class Bar
  def pass(glass, to:)
  end
end

class Bartender
  def initialize
    @shaker = Shaker.new
    @glass = Glass.new
    @bar = Bar.new
  end

  def make_drink(name, customer:)
    if name == :negroni
      drink = @shaker.combine(:gin, :campari, :sweet_vermouth)
      @glass.pour!(drink)
      @bar.pass(@glass, to: customer)
    end
  end
end
