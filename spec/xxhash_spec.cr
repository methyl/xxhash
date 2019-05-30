require "spec"
require "../src/xxhash"

describe Xxhash do
  it "calculates hash64" do
    Xxhash.hash64("test hash").should eq(11437837717929986876)
  end
end
