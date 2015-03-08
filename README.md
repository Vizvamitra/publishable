## Publishable

Adds publishable logics to your rails models
-----

#### Installation

Add this to your gemfile:
    
    gem 'publishable', github: 'tvch1/publishable'

Publishable operates with three fields of your model:

- published:boolean
- published_at:datetime
- expires_at:datetime

, so you'll need to add them.
(with `rails generate migration AddPublishableFieldsToPages published:boolean published_at:datetime expires_at:datetime`, for example)

Now you can include Publishable concern in your model:

```
class Page < ActiveRecord::Base
    include Publishable

    # ... your code ...
end
```

#### Features

This concern brings four publish-related states to you model:
`:published`, `:planned`, `:expired` and `:draft`. By default (after creation) record starts as a draft, which means it has `published: false`. State will change depending on :published, :published_at and :expires_at values

You can get current state with `#state` method, which will returs symbol name of record's current status

It also adds four predicate methods:

1. `page.published?`
2. `page.draft?`
3. `page.planned?`
4. `page.expired?`

and some scopes:

1. `Page.published`
2. `Page.not_published` # planned, expired and drafts altogether
3. `Page.planned`
4. `Page.expired`
5. `Page.drafts`

#### Supported orms
   
Gem supports ActiveRecord and Mongoid.

If you need support of other orm, you can define your own scopes module for it. See [ActiveRecord scopes][1] or [Mongoid scopes][2] for an example.

#### Contacts

You can contact me via email: <vizvamitra@gmail.com>
Feel free to make pull requests or create issues)

Dmitrii Krasnov

[1]: lib/publishable/scopes/active_record.rb
[2]: lib/publishable/scopes/mongoid.rb