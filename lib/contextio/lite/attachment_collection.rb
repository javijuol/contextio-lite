require 'contextio/api/resource_collection'
require_relative 'attachment'

module ContextIO
  class Lite
    class AttachmentCollection
      include ContextIO::API::ResourceCollection

      self.resource_class = ContextIO::Lite::Attachment
      self.association_name = :attachment_files

      belongs_to :message
    end
  end
end