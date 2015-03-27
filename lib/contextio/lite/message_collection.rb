require 'contextio/api/resource_collection'
require_relative 'message'

module ContextIO
  class Lite
    class MessageCollection
      include ContextIO::API::ResourceCollection

      self.resource_class = ContextIO::Lite::Message
      self.association_name = :messages

      belongs_to :folder
    end
  end
end
