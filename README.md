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
`:published`, `:planned`, `:expired` and `:draft`. By default (after creation) record starts as a draft, witch means it has `published: false`. State will change depending on :published, :published_at and :expires_at values

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

#### Contacts

You can contact me via email: <vizvamitra@gmail.com>
Feel free to make pull requests or create issues)

Dmitrii Krasnov