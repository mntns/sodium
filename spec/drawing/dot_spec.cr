require "../spec_helper"

describe Sodium::Drawing::Dot do
  g = Sodium::Graph(Int32).new
  g.add_cycle([1,2,3,4])

  describe "#generate_dot" do
    it "generates dot string" do
      Sodium.generate_dot(g).should_not eq("")
    end
  end
end
