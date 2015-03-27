require 'contextio/api/resource_collection'
require_relative 'user'

module ContextIO
  class Lite
    class UserCollection
      include ContextIO::API::ResourceCollection

      self.resource_class = ContextIO::Lite::User
      self.association_name = :accounts

      # Creates a new email account for your Context.IO account.
      #
      # @param [Hash{String, Symbol => String}] options Information you can
      #   provide at creation: email, first_name and/or last_name. If the
      #   collection isn't already limited by email, then you must provide it.
      #
      # @return [Account] A new email account instance based on the data you
      #   input.
      def create(options={})
        email = options.delete(:email) || options.delete('email') ||
          where_constraints[:email] || where_constraints['email']

        if email.nil?
          raise ArgumentError, 'You must provide an email for new Users.'
        end

        result_hash = api.request(
          :post,
          resource_url,
          options.merge(email: email)
        )

        result_hash.delete('success')

        resource_class.new(api, result_hash)
      end
    end
  end
end
