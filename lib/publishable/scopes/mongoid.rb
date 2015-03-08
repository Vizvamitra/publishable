module Publishable
  module Scopes

    module Mongoid
      extend ActiveSupport::Concern

      def self.for? model
        model.ancestors.map(&:to_s).include? 'Mongoid::Document'
      end

      included do |base|
        scope :published, ->{
          now = Time.now
          where(:published_at.lte => now).
          or(expires_at: nil).
          or(:expires_at.gt => now)
        }

        scope :not_published, ->{
          now = Time.now
          self.or(:published.in => [nil, false]).
          or(:published_at.gt => now).
          or(:expires_at.lte => now)
        }

        scope :planned, ->{
          where(published: true).and(:published_at.gt => Time.now)
        }

        scope :expired, ->{
          where(published: true).and(:expires_at.lte =>Time.now)
        }

        scope :drafts, ->{ where(published: false) }
      end
    end
    
  end
end