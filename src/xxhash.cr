require "./LibXXH"

module Xxhash
  VERSION = "0.8.2"

  class Hash3
    @state : LibXXHash::XXH3_State*
    @closed : Bool

    def initialize(seed : LibC::UInt = 0)
      @closed = false
      @state = LibXXHash.hash3_create_state

      if seed == 0
        unless LibXXHash.hash3_reset(@state) == LibXXHash::Errorcode::OK
          raise XXHashError.new("Cannot initialize hash3 state")
        end
      else
        unless LibXXHash.hash3_reset_withSeed(@state, seed) == LibXXHash::Errorcode::OK
          raise XXHashError.new("Cannot initialize hash3 state")
        end
      end
    end

    def self.open()
      hash3 = new()
      yield hash3 ensure hash3.close
    end

    def self.open_with_seed(seed : LibC::UInt)
      hash3 = new(seed: seed)
      yield hash3 ensure hash3.close
    end

    def reset(seed : LibC::UInt = 0)
      initialize(seed: seed)
    end

    def update(slice : Bytes)
      return if @closed
      unless LibXXHash.hash3_update(@state, slice, slice.size.to_u64) == LibXXHash::Errorcode::OK
        raise XXHashError.new("Cannot update hash3")
      end
    end

    def digest : LibC::UInt|Nil
      return if @closed
      LibXXHash.hash3_digest(@state)
    end

    def close
      return if @closed
      unless LibXXHash.hash3_free_state(@state) == LibXXHash::Errorcode::OK
        raise XXHashError.new("Cannot close hash3")
      end
      @closed = true
    end

    def self.hash(slice : Bytes) : LibC::UInt
      LibXXHash.hash3_straight(slice, slice.size)
    end

    def self.hash_with_seed(slice : Bytes, seed : LibC::UInt) : LibC::UInt
      LibXXHash.hash3_straight_withSeed(slice, slice.size, seed)
    end

    def self.hash(text : String) : LibC::UInt
      self.hash(text.to_slice)
    end

    def self.hash_with_seed(text : String, seed : LibC::UInt) : LibC::UInt
      self.hash_with_seed(text.to_slice, seed: seed)
    end
  end

  class Hash32
    @state : LibXXHash::XXH32_State*
    @closed : Bool

    def initialize(seed : LibC::UInt = 0)
      @closed = false
      @state = LibXXHash.hash32_create_state
      unless LibXXHash.hash32_reset(@state, seed) == LibXXHash::Errorcode::OK
        raise XXHashError.new("Cannot initialize hash32 state")
      end
    end

    def self.open(seed : LibC::UInt = 0)
      hash32 = new(seed: seed)
      yield hash32 ensure hash32.close
    end

    def reset(seed : LibC::UInt = 0)
      initialize(seed: seed)
    end

    def update(slice : Bytes)
      return if @closed
      unless LibXXHash.hash32_update(@state, slice, slice.size.to_u64) == LibXXHash::Errorcode::OK
        raise XXHashError.new("Cannot update hash32")
      end
    end

    def digest : LibC::UInt|Nil
      return if @closed
      LibXXHash.hash32_digest(@state)
    end

    def close
      return if @closed
      unless LibXXHash.hash32_free_state(@state) == LibXXHash::Errorcode::OK
        raise XXHashError.new("Cannot close hash32")
      end
      @closed = true
    end

    def self.hash(slice : Bytes, seed : LibC::UInt = 0) : LibC::UInt
      LibXXHash.hash32_straight(slice, slice.size, seed)
    end

    def self.hash(text : String, seed : LibC::UInt = 0) : LibC::UInt
      self.hash(text.to_slice, seed: seed)
    end
  end

  class Hash64
    @state : LibXXHash::XXH64_State*
    @closed : Bool

    def initialize(seed : LibC::ULongLong = 0)
      @closed = false
      @state = LibXXHash.hash64_create_state
      unless LibXXHash.hash64_reset(@state, seed) == LibXXHash::Errorcode::OK
        raise XXHashError.new("Cannot initialize hash64 state")
      end
    end

    def self.open(seed : LibC::ULongLong = 0)
      hash64 = new(seed: seed)
      yield hash64 ensure hash64.close
    end

    def reset(seed : LibC::ULongLong = 0)
      initialize(seed: seed)
    end

    def update(slice : Bytes)
      return if @closed
      unless LibXXHash.hash64_update(@state, slice, slice.size.to_u64) == LibXXHash::Errorcode::OK
        raise XXHashError.new("Cannot update hash64")
      end
    end

    def digest : LibC::ULongLong|Nil
      return if @closed
      LibXXHash.hash64_digest(@state)
    end

    def close
      return if @closed
      unless LibXXHash.hash64_free_state(@state) == LibXXHash::Errorcode::OK
        raise XXHashError.new("Cannot close hash64")
      end
      @closed = true
    end

    def self.hash(slice : Bytes, seed : LibC::ULongLong = 0) : LibC::ULongLong
      LibXXHash.hash64_straight(slice, slice.size, seed)
    end

    def self.hash(text : String, seed : LibC::ULongLong = 0) : LibC::ULongLong
      self.hash(text.to_slice, seed: seed)
    end
  end

  def self.hash128(slice : Bytes, seed : LibC::ULongLong = 0) : LibXXHash::XXH128_Hash
    LibXXHash.hash128_straight(slice, slice.size, seed)
  end

  def self.hash128(text : String, seed : LibC::ULongLong = 0) : LibXXHash::XXH128_Hash
    hash128(text.to_slice, seed: seed)
  end

  class XXHashError < Exception
  end

end
