module ContextIO
	VERSION = '0.0.4'

	# @private
	# Handle for the `API` instance. For internal use only.
	attr_reader :api

	def self.version
		VERSION
	end

	def self.lite(key,secret,options={})
		ContextIO::Lite.new(key,secret,options)
	end

end

require_relative 'contextio/api/association_helpers'
require_relative 'contextio/api/resource'
require_relative 'contextio/api/resource_collection'

require_relative 'contextio/lite'