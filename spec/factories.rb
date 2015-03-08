FactoryGirl.define do

  factory :post do
    sequence(:title){ |n| "post #{n}" }
    body { "test body" }
    
    trait(:published){ published true; published_at DateTime.yesterday }
    trait(:planned){ published true; published_at DateTime.tomorrow }
    trait(:expired){ published true; published_at DateTime.yesterday; expires_at DateTime.yesterday }
    trait(:draft){ published false }
    trait(:not_published){ published false }
  end

  factory :news, class: 'News', parent: :post
end