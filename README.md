# Crystal xxhash

Crystal bindings to extremely fast hash algorithm xxHash (http://www.xxhash.com)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     xxhash:
       github: methyl/xxhash
   ```

2. Run `shards install`

## Usage

```crystal
require "xxhash"

assert Xxhash.hash64("test hash") == 11437837717929986876
```

## Development

### Updating xxHash

```
cd src/xxHash
git pull
```

### TODO

- [ ] Support xxh3
- [ ] Support streaming variant
- [x] Support xxhash32, xxhash128
- [x] Support custom seeding
- [x] Support hashing other types than string

## Contributing

1. Fork it (<https://github.com/methyl/xxhash/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Lucjan Suski](https://github.com/methyl) - creator and maintainer
