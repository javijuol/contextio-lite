require 'contextio/api/resource'
require 'contextio/api/association_helpers'

module ContextIO
  class Lite
    class User
      include ContextIO::API::Resource

      self.primary_key = :id
      self.association_name = :user

      has_many :email_accounts
      has_many :webhooks

      # @!attribute [r] id
      #   @return [String] The id assigned to this account by Context.IO.
      # @!attribute [r] username
      #   @return [String] The username assigned to this account by Context.IO.
      # @!attribute [r] first_name
      #   @return [String] The account holder's first name.
      # @!attribute [r] last_name
      #   @return [String] The account holder's last name.
      lazy_attributes :id, :email_addresses, :username, :created, :first_name, :last_name
      private :created

      # @!attribute [r] created_at
      #   @return [Time] The time this account was created (with Context.IO).
      def created_at
        @created_at ||= Time.at(created)
      end

      # Updates the account.
      #
      # @param [Hash{String, Symbol => String}] options You can update first_name
      #   or last_name (or both).
      def update(options={})
        first_name = options[:first_name] || options['first_name']
        last_name = options[:last_name] || options['last_name']

        attrs = {}
        attrs[:first_name] = first_name if first_name
        attrs[:last_name] = last_name if last_name

        return nil if attrs.empty?

        it_worked = api.request(:post, resource_url, attrs)['success']

        if it_worked
          @first_name = first_name || @first_name
          @last_name = last_name || @last_name
        end

        it_worked
      end

      def delete
        api.request(:delete, resource_url)['success']
      end
    end
  end
end
