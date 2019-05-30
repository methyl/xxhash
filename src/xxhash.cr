@[Link(ldflags: "#{__DIR__}/xxHash/xxhash.o")]
lib LibXXHash
  fun hash64 = XXH64(input : UInt8*, size : LibC::SizeT, seed : UInt64) : UInt64
end

module Xxhash
  VERSION = "0.1.2"

  def self.hash64(text : String)
    input = text.bytes
    size = text.bytesize
    LibXXHash.hash64(input, size, 0)
  end
end
