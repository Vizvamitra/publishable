module Publishable
  module Scopes
    
    module ActiveRecord
      extend ActiveSupport::Concern

      def self.for? model
        model.ancestors.map(&:to_s).include? 'ActiveRecord::Base'
      end

      included do |base|
        scope :published, ->{
          where(published: true).
          where('published_at <= CURRENT_TIMESTAMP').
          where('expires_at IS NULL OR expires_at > CURRENT_TIMESTAMP')
        }

        scope :not_published, ->{
          where("published = #{::ActiveRecord::Base.connection.quoted_false} OR published IS NULL OR published_at > CURRENT_TIMESTAMP OR expires_at <= CURRENT_TIMESTAMP")
        }

        scope :planned, ->{
          where(published: true).where('published_at > CURRENT_TIMESTAMP')
        }

        scope :expired, ->{
          where(published: true).where('expires_at <= CURRENT_TIMESTAMP')
        }
        
        scope :drafts, ->{ where(published: false) }
      end
    end
    
  end
end