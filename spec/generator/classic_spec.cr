require "../spec_helper"

describe Sodium::Generator::Classic do
  it "generate complete graph" do
    gen = Sodium::Generator::Classic(Int32).new()
    g = gen.complete_graph(200)
  end
end
