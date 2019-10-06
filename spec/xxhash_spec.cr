require "spec"
require "../src/xxhash"

describe Xxhash do
  context "calculates hash128 with" do
    it "default seed" do
      expected_hash = LibXXHash::XXH128_Hash.new(low64: 8783152424331972946, high64: 11833394359751653786)
      Xxhash.hash128("test hash").should eq(expected_hash)
    end
    it "11 as seed" do
      expected_hash = LibXXHash::XXH128_Hash.new(low64: 2734930085301639998, high64: 422024697275480028)
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
