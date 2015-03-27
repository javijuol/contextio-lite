require 'contextio/api/resource_collection'
require_relative 'webhook'

module ContextIO
  class Lite
    class WebhookCollection
      include ContextIO::API::ResourceCollection

      self.resource_class = ContextIO::Lite::Webhook
      self.association_name = :webhooks

      belongs_to :user

      def create(callback_url, errback_url, options={})
        api_args = options.merge(
          'callback_url' => callback_url,
          'failure_notif_url' => errback_url
        )

        result_hash = api.request(:post, resource_url, api_args)

        result_hash.delete('success')

        resource_class.new(api, result_hash)
      end
    end
  end
end
