module ContextIO
  class Lite
    include ContextIO


    # Creates a new `ContextIO` instance and makes a new handle for the API.
    # This is your entry point to your Context.IO account.  For a web app, you
    # probably want to instantiate this in some kind of initializer and keep it
    # around for the life of the process.
    #
    # @param [String] key Your OAuth consumer key for your Context.IO account
    # @param [String] secret Your OAuth consumer secret for your Context.IO
    #   account
    # @param [Hash] opts Optional options for OAuth connections. ie. :timeout and :open_timeout are supported
    def initialize(key, secret, opts={})
      @api = API.new(key, secret, opts)
    end

    # Your entry point for dealing with users.
    #
    # @return [Users] Allows you to work with the email accounts for
    #   your account as a group.
    def users
      UserCollection.new(api)
    end
  end
end

require_relative 'api/association_helpers'
require_relative 'api/resource'
require_relative 'api/resource_collection'

require_relative 'lite/api'
require_relative 'lite/email_account'
require_relative 'lite/email_account_collection'
require_relative 'lite/folder'
require_relative 'lite/folder_collection'
require_relative 'lite/message'
require_relative 'lite/message_collection'
require_relative 'lite/user'
require_relative 'lite/user_collection'
require_relative 'lite/webhook'
require_relative 'lite/webhook_collection'