class Post
  include ::Mongoid::Document

  field :title, type: String
  field :body, type: String
  field :published, type: Boolean
  field :published_at, type: DateTime
  field :expires_at, type: DateTime

  include Publishable
end
