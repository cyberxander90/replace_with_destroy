# Replace with Destroy
Based on Rails guide [Automatic deletion of join models is direct, no destroy callbacks are triggered.](https://guides.rubyonrails.org/association_basics.html#the-has-many-through-association), which means, Rails will not run destroy callbacks for `has_many` through join model.

This gem allow you running the destroy callbacks in the join model.

This could be useful if you are using [paranoia](https://github.com/rubysherpas/paranoia) and you want change it to un-active instead delete the join model.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'replace_with_destroy'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install replace_with_destroy
```

## Usage
### *replace_with_destroy* option.  
Pass the option `replace_with_destroy: true` to the `has_many` method.
```
class User < ApplicationRecord
  has_many :bookings
  has_many :rooms, through: :bookings, replace_with_destroy: true
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  after_destroy :my_custom_method

  def my_custom_method
    # do whatever you want here ...
  end
end

class Room < ApplicationRecord
  ...
end
```

Then, given the User `user` with rooms `[1,2,3]` you can change his `rooms` and this automatically call Booking destroy callbacks.
```
# given a User with rooms
> user.room_ids
[1, 2, 3]

# you can change his rooms
user.room_ids = [3, 4, 5]
# this add the rooms 4 and 5 and remove the rooms 1 and 2
# my_custom_method will be executed for rooms 1 and 2 when being removed
```

### global *replace_with_destroy* option.
You can add this behavior for all `has_many` methods without need to pass it as option.

To do that, create an initializer, for example `config/initializers/replace_with_destroy.rb`, and put the following code
```
ReplaceWithDestroy::ALL = true
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
