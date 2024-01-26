@[Link(ldflags: "#{__DIR__}/xxHash/xxhash.o")]
lib LibXXHash
  type XXH32_State = Void

  type XXH64_State = Void

  type XXH3_State = Void

  fun hash3_create_state = XXH3_createState : XXH3_State*

  fun hash3_free_state = XXH3_freeState(state_ptr : XXH3_State*) : Errorcode

  fun hash3_reset = XXH3_64bits_reset(state_ptr : XXH3_State*) : Errorcode

  fun hash3_reset_withSeed = XXH3_64bits_reset_withSeed(state_ptr : XXH3_State*, seed : LibC::UInt) : Errorcode

  fun hash3_update = XXH3_64bits_update(state_ptr : XXH3_State*, input : Void*, length : LibC::SizeT) : Errorcode

  fun hash3_digest = XXH3_64bits_digest(state_ptr : XXH3_State*) : LibC::UInt

  fun hash3_straight = XXH3_64bits(input : Void*, size : LibC::SizeT) : LibC::UInt

  fun hash3_straight_withSeed = XXH3_64bits_withSeed(input : Void*, size : LibC::SizeT, seed : LibC::UInt) : LibC::UInt

  fun hash64_straight = XXH64(input : Void*, size : LibC::SizeT, seed : LibC::ULongLong) : LibC::ULongLong

  fun hash32_straight = XXH32(input : Void*, size : LibC::SizeT, seed : LibC::UInt) : LibC::UInt

  fun hash32_create_state = XXH32_createState : XXH32_State*

  fun hash32_free_state = XXH32_freeState(state_ptr : XXH32_State*) : Errorcode

  fun hash32_reset = XXH32_reset(state_ptr : XXH32_State*, seed : LibC::UInt) : Errorcode

  fun hash32_update = XXH32_update(state_ptr : XXH32_State*, input : Void*, length : LibC::SizeT) : Errorcode

  fun hash32_digest = XXH32_digest(state_ptr : XXH32_State*) : LibC::UInt

  fun hash64_straight = XXH64(input : Void*, size : LibC::SizeT, seed : LibC::ULongLong) : LibC::ULongLong

  fun hash64_create_state = XXH64_createState : XXH64_State*

  fun hash64_free_state = XXH64_freeState(state_ptr : XXH64_State*) : Errorcode

  fun hash64_reset = XXH64_reset(state_ptr : XXH64_State*, seed : LibC::ULongLong) : Errorcode

  fun hash64_update = XXH64_update(state_ptr : XXH64_State*, input : Void*, length : LibC::SizeT) : Errorcode

  fun hash64_digest = XXH64_digest(state_ptr : XXH64_State*) : LibC::ULongLong

  fun hash128_straight = XXH128(input : Void*, size : LibC::SizeT, seed : LibC::ULongLong) : XXH128_Hash

  struct XXH128_Hash
    low64, high64 : LibC::ULongLong
  end

  enum Errorcode
    OK = 0
    ERROR
  end
end
