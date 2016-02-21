require 'contextio/api/resource'
require 'contextio/api/association_helpers'

module ContextIO
  class Lite
    class Attachment
      include ContextIO::API::Resource
      self.primary_key = :attachment_id
      self.association_name = :attachment_file
      lazy_attributes :headers, :content
    end
  end
end