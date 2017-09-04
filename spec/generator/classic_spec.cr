require "../spec_helper"
include Sodium::Generator::Classic(Int32)

describe Sodium::Generator::Classic do
  it "generate complete graph" do
    g = complete_graph(200)
    p g.nodes
  end
end
