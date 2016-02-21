require_relative 'email_account_collection'
require_relative 'folder_collection'
require_relative 'message_collection'
require_relative 'user_collection'
require_relative 'webhook_collection'
require_relative 'attachment_collection'

module ContextIO
  class Lite
    class URLBuilder
      class Error < StandardError; end

      # Tells you the right URL for a resource to fetch attributes from.
      #
      # @param [Contextio::Resource, Contextio::ResourceCollection] resource The
      #   resource or resource collection.
      #
      # @return [String] The path for that resource in the API.
      def self.url_for(resource)
        if (builder = @registered_urls[resource.class])
          builder.call(resource)
        else
          raise Error, "URL could not be built for unregistered Class: #{resource.class}."
        end
      end

      # Register a block that calculates the URL for a given resource.
      #
      # @param [Class] resource_class The class of the resource you are
      #   registering.
      # @param [Block] block The code that will compute the url for the
      #   resource. This is actually a path. Start after the version number of
      #   the API in the URL. When a URL is being calculated for a specific
      #   resource, the resource instance will be yielded to the block.
      #
      # @example For Accounts
      #   register_url ContextIO::Account do |account|
      #     "accounts/#{account.id}"
      #   end
      def self.register_url(resource_class, &block)
        @registered_urls ||= {}
        @registered_urls[resource_class] = block
      end

      register_url ContextIO::Lite::UserCollection do
        'users'
      end

      register_url ContextIO::Lite::User do |user|
        "users/#{user.id}"
      end

      register_url ContextIO::Lite::EmailAccountCollection do |email_accounts|
        "users/#{email_accounts.user.id}/email_accounts"
      end

      register_url ContextIO::Lite::EmailAccount do |email_account|
        "users/#{email_account.user.id}/email_accounts/#{email_account.label}"
      end

      register_url ContextIO::Lite::FolderCollection do |folders|
        "users/#{folders.email_account.user.id}/email_accounts/#{uri_encode folders.email_account.label}/folders"
      end

      register_url ContextIO::Lite::Folder do |folder|
        "users/#{folder.email_account.user.id}/email_accounts/#{uri_encode folder.email_account.label}/folders/#{uri_encode folder.name}"
      end

      register_url ContextIO::Lite::MessageCollection do |messages|
        "users/#{messages.folder.email_account.user.id}/email_accounts/#{uri_encode messages.folder.email_account.label}/folders/#{uri_encode messages.folder.name}/messages"
      end

      register_url ContextIO::Lite::Message do |message|
        "users/#{message.folder.email_account.user.id}/email_accounts/#{uri_encode message.folder.email_account.label}/folders/#{uri_encode message.folder.name}/messages/#{uri_encode message.message_id}"
      end


      register_url ContextIO::Lite::WebhookCollection do |webhooks|
        "users/#{webhooks.user.id}/webhooks"
      end

      register_url ContextIO::Lite::Webhook do |webhook|
        "users/#{webhook.user.id}/webhooks/#{webhook.webhook_id}"
      end

      register_url ContextIO::Lite::AttachmentCollection do |attachments|
        "users/#{attachments.message.folder.email_account.user.id}/email_accounts/#{uri_encode attachments.message.folder.email_account.label}/folders/#{uri_encode attachments.message.folder.name}/messages/#{uri_encode attachments.message.message_id}/attachments"
      end

      register_url ContextIO::Lite::Attachment do |attachment|
        "users/#{attachment.message.folder.email_account.user.id}/email_accounts/#{uri_encode attachment.message.folder.email_account.label}/folders/#{uri_encode attachment.message.folder.name}/messages/#{uri_encode attachment.message.message_id}/attachments/#{attachment.attachment_id}"
      end

      def self.uri_encode(param)
        if param.is_a? String
          URI.encode param
        else
          param
        end
      end

    end
  end
end
