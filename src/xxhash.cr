@[Link(ldflags: "#{__DIR__}/xxHash/xxhash.o")]
lib LibXXHash
  fun hash128 = XXH128(input : Void*, size : LibC::SizeT, seed : LibC::ULongLong) : XXH128_Hash

  fun hash64 = XXH64(input : Void*, size : LibC::SizeT, seed : LibC::ULongLong) : LibC::ULongLong

  fun hash32 = XXH32(input : Void*, size : LibC::SizeT, seed : LibC::UInt) : LibC::UInt

  struct XXH128_Hash
    low64, high64 : LibC::ULongLong
  end
end

module Xxhash
  VERSION = "0.2.0"

  def self.hash128(text : String, seed : LibC::ULongLong = 0)
    hash128(text.to_slice, seed: seed)
  end

  def self.hash128(slice : Bytes, seed : LibC::ULongLong = 0)
    LibXXHash.hash128(slice, slice.size, seed)
  end

  def self.hash64(text : String, seed : LibC::ULongLong = 0)
    hash64(text.to_slice, seed: seed)
  end

  def self.hash64(slice : Bytes, seed : LibC::ULongLong = 0)
    LibXXHash.hash64(slice, slice.size, seed)
  end

  def self.hash32(text : String, seed : LibC::UInt = 0)
    hash32(text.to_slice, seed: seed)
  end

  def self.hash32(slice : Bytes, seed : LibC::UInt = 0)
    LibXXHash.hash32(slice, slice.size, seed)
  end
end
