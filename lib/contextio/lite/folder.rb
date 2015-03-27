require 'contextio/api/resource'
require 'contextio/api/association_helpers'

module ContextIO
  class Lite
    class Folder
      include ContextIO::API::Resource

      self.primary_key = :name
      self.association_name = :folder

      has_many :messages

      lazy_attributes :name, :delimiter, :nb_messages, :nb_unseen_messages

    end
  end
end
