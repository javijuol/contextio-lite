require 'contextio/api/resource_collection'
require_relative 'folder'

module ContextIO
  class Lite
    class FolderCollection
      include ContextIO::API::ResourceCollection

      self.resource_class = ContextIO::Lite::Folder
      self.association_name = :folders

      belongs_to :email_account

    end
  end
end

