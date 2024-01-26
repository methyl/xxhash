require "spec"
require "../src/xxhash"

describe Xxhash do
  context "calculates hash128 with" do
    it "default seed" do
      expected_hash = LibXXHash::XXH128_Hash.new(low64: 15780237998991156563u64, high64: 17782204679809390182u64)
      Xxhash.hash128("test hash").should eq(expected_hash)
    end
    it "11 as seed" do
      expected_hash = LibXXHash::XXH128_Hash.new(low64: 14988455901029385735u64, high64: 55652544739171944u64)
      Xxhash.hash128("test hash", 11).should eq(expected_hash)
    end
  end
  context "calculates hash3" do
    context "in straightforward mode with" do
      it "default seed" do
        Xxhash::Hash3.hash("test hash").should eq(4185100473)
      end
      it "12 as seed" do
        Xxhash::Hash3.hash_with_seed("test hash", 12).should eq(3925787575)
      end
    end
    context "in streaming mode with" do
      it "default seed" do
        Xxhash::Hash3.open do |hash|
          hash.update("test hash".to_slice)
          hash.digest.should eq(4185100473)
        end
      end
      it "12 as seed" do
        Xxhash::Hash3.open_with_seed(12) do |hash|
          hash.update("test hash".to_slice)
          hash.digest.should eq(3925787575)
        end
      end
      it "82588 as seed" do
        Xxhash::Hash3.open_with_seed(82558) do |hash|
          File.open("./spec/dummy.txt") do |file|
            hash.update(file.gets_to_end.to_slice)
          end
          hash.digest.should eq(2367236785)
        end
      end
    end
  end
  context "calculates hash64" do
    context "in straightforward mode with" do
      it "default seed" do
        Xxhash::Hash64.hash("test hash").should eq(11437837717929986876u64)
      end
      it "12 as seed" do
        Xxhash::Hash64.hash("test hash", 12).should eq(17909425895861273630u64)
      end
    end
    context "in streaming mode with" do
      it "default seed" do
        Xxhash::Hash64.open do |hash|
          hash.update("test hash".to_slice)
          hash.digest.should eq(11437837717929986876u64)
        end
      end
      it "12 as seed" do
        Xxhash::Hash64.open(12) do |hash|
          hash.update("test hash".to_slice)
          hash.digest.should eq(17909425895861273630u64)
        end
      end
      it "82588 as seed" do
        Xxhash::Hash64.open(82558) do |hash|
          File.open("./spec/dummy.txt") do |file|
            hash.update(file.gets_to_end.to_slice)
          end
          hash.digest.should eq(925394387188055322u64)
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
      it "82588 as seed" do
        Xxhash::Hash32.open(82558) do |hash|
          File.open("./spec/dummy.txt") do |file|
            hash.update(file.gets_to_end.to_slice)
          end
          hash.digest.should eq(2938057424)
        end
      end
    end
  end
end
