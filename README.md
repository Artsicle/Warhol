## Usage

Call `warhol_methods` in an ActiveRecord class

``` ruby
class Artwork < ActiveRecord::Base
	warhol_methods
end
```

This will automatically save the last changes to the model in the cache or redis and be easily retrievable for viewing what's been changed.

## Development

TODO
- Don't include updated_at as a change
- Ability to exclude or filter columns
- Show how the attribute changed. (From what to what)
- Easily check off changes and remove from memory
- Represent a group of attributes as one
	i.e paperclip/image attributes as 'avatar'
- Handle has many associations gracefully
- Switch to Rails.cache instead of Redis, or storage choice