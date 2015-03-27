require 'contextio/api/resource'
require 'contextio/api/association_helpers'

module ContextIO
  class Lite
    class Message
      include ContextIO::API::Resource

      self.primary_key = :message_id
      self.association_name = :message

      # has_many :body_parts

      lazy_attributes :sent_at, :addresses, :person_info, :email_message_id, :message_id,
                      :attachments, :subject, :folders, :bodies, :references, :in_reply_to,
                      :list_headers, :received_headers

      FLAG_KEYS = %w(seen answered flagged draft deleted)

      private :sent_at, :bodies, :addresses

      def sent
        @sent ||= Time.at(sent_at)
      end

      %w(from to bcc cc reply_to).each do |f|
        define_method(f) do
          addresses[f]
        end
      end

      def body_plain
        self.body(type:'text/plain').map{|b| b['content']}.join
      end

      def body_html
        self.body(type:'text/html').map{|b| b['content']}.join
      end

      def body(options={})
        @body ||= if @with_constraints.has_key?(:include_body) && @with_constraints[:include_body]==1 then
                    options.has_key?('type') ?
                        self.api_attributes['bodies'].select { |b| b['type']==options['type'] } :
                        self.api_attributes['bodies']
                  else
                    api.request(:get, "#{resource_url}/body", options)['bodies']
                  end
      end

      def flags
        if @with_constraints.has_key?(:include_flags) && @with_constraints[:include_flags]==1
          @flags = self.api_attributes['flags']
        else
          @flags ||= api.request(:get, "#{resource_url}/flags")['flags']
          @flags['seen'] = @flags.delete 'read' if @flags.has_key? 'read'
          @flags = Hash[FLAG_KEYS.map{|f| [f, @flags.include?(f) && @flags[f]]}]
        end
        @flags
      end

      def headers
        @headers ||= @with_constraints.has_key?(:include_headers) && @with_constraints[:include_headers]==1 ?
          self.api_attributes['headers'] :
          api.request(:get, "#{resource_url}/headers")['headers']
      end

      def raw
        api.raw_request(:get, "#{resource_url}/raw")
      end

      def read
        api.request(:post, "#{resource_url}/read")['success']
      end

    end
  end
end
