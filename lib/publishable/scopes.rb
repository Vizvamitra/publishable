require 'publishable/scopes/active_record'
require 'publishable/scopes/mongoid'

module Publishable
  module Scopes
    def self.for(model)
      modules = constants.map{|constant| "Publishable::Scopes::#{constant}".constantize}
      scopes = modules.select{|scopes| scopes.for?(model)}.first
      raise UnknownOrmError unless scopes
      scopes
    end
  end
end