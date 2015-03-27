require 'contextio/api/resource'
require 'contextio/api/association_helpers'

module ContextIO
  class Lite
    class Webhook
      include ContextIO::API::Resource

      self.primary_key = :webhook_id
      self.association_name = :webhook

      lazy_attributes :callback_url, :failure_notif_url, :active, :webhook_id,
                      :active, :failure,
                      :filter_to, :filter_from, :filter_cc,
                      :filter_subject, :filter_thread, :filter_new_important,
                      :filter_file_name, :filter_folder_added,
                      :filter_to_domain, :filter_folder_domain,
                      :include_body, :body_type

      private :active, :failure

      def active?
        !!active
      end

      def failure?
        !!failure
      end

      def activate
        api.request(:post, resource_url, active: 1)['success']
      end

      def deactivate
        api.request(:post, resource_url, active: 0)['success']
      end

      def delete
        api.request(:delete, resource_url)['success']
      end
    end
  end
end
