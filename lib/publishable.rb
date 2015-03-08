require 'publishable/scopes'

module Publishable
  extend ActiveSupport::Concern

  class UnknownOrmError < StandardError; end

  included do |base|
    include Scopes.for(base)
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
