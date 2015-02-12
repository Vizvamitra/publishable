module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(published: true).where('published_at <= CURRENT_TIMESTAMP').where('expires_at IS NULL OR expires_at > CURRENT_TIMESTAMP') }
    scope :not_published, -> { where("published = #{ActiveRecord::Base.connection.quoted_false} OR published IS NULL OR published_at > CURRENT_TIMESTAMP OR expires_at <= CURRENT_TIMESTAMP") }
    scope :planned, -> { where(published: true).where('published_at > CURRENT_TIMESTAMP') }
    scope :expired, -> { where(published: true).where('expires_at <= CURRENT_TIMESTAMP') }
    scope :drafts, -> { where(published: false) }

    validates_presence_of :published_at, if: -> { self[:published] }
  end

  module ClassMethods
    def autoset_published_at
      self.class_eval do
        before_validation :handle_published_status_change, if: ->{ published_changed? || new_record?}
      end
    end
  end

  def handle_published_status_change
    self[:published_at] = DateTime.now if published && published_at.nil?
  end

  def status
    if !published
      :draft
    elsif expires_at.present? && expires_at <= DateTime.now
      :expired
    elsif published_at > DateTime.now
      :planned
    elsif published_at <= DateTime.now
      :published
    else
      :error
    end
  rescue NoMethodError => e
    :error
  end

  def published?
    status == :published
  end

  def planned?
    status == :planned
  end

  def draft?
    status == :draft
  end

  def expired?
    status == :expired
  end
end
