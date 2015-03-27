module ContextIO
	VERSION = '0.0.2'

	# @private
	# Handle for the `API` instance. For internal use only.
	attr_reader :api

	def self.version
		VERSION
	end

end

require_relative 'contextio/lite'