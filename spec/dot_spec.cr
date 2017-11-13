require "./spec_helper"

describe Sodium::Dot do
  g = Sodium::Graph(Int32).new
  g.add_cycle([1,2,3,4])

  describe "#generate_dot" do
    it "should output something" do
      dot = Sodium::Dot.new.generate_dot g
      dot.should_not eq("")
    end
  end
end
