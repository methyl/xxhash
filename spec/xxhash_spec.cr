require "spec"
require "../src/xxhash"

describe Xxhash do
  context "calculates hash128 with" do
    it "default seed" do
      expected_hash = LibXXHash::XXH128_Hash.new(low64: 12072926232526126181, high64: 10536754791245776143)
      Xxhash.hash128("test hash").should eq(expected_hash)
    end
    it "11 as seed" do
      expected_hash = LibXXHash::XXH128_Hash.new(low64: 421465192517327795, high64: 9879049699729167117)
      Xxhash.hash128("test hash", 11).should eq(expected_hash)
    end
  end
  context "calculates hash64" do
    context "in straightforward mode with" do
      it "default seed" do
        Xxhash::Hash64.hash("test hash").should eq(11437837717929986876)
      end
      it "12 as seed" do
        Xxhash::Hash64.hash("test hash", 12).should eq(17909425895861273630)
      end
    end
    context "in streaming mode with" do
      it "default seed" do
        Xxhash::Hash64.open do |hash|
          hash.update("test hash".to_slice)
          hash.digest.should eq(11437837717929986876)
        end
      end
      it "12 as seed" do
        Xxhash::Hash64.open(12) do |hash|
          hash.update("test hash".to_slice)
          hash.digest.should eq(17909425895861273630)
        end
      end
    end
  end
  context "calculates hash32" do
    context "in straightforward mode with" do
      it "default seed" do
        Xxhash::Hash32.hash("test hash").should eq(814550234)
      end
      it "13 as seed" do
        Xxhash::Hash32.hash("test hash", 13).should eq(2647094367)
      end
    end
    context "in streaming mode with" do
      it "default seed" do
        Xxhash::Hash32.open do |hash|
          hash.update("test hash".to_slice)
          hash.digest.should eq(814550234)
        end
      end
      it "13 as seed" do
        Xxhash::Hash32.open(13) do |hash|
          hash.update("test hash".to_slice)
          hash.digest.should eq(2647094367)
        end
      end
    end
  end
end
