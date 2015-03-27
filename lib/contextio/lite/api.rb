require 'contextio/api/abstract_api'
require_relative 'url_builder'

module ContextIO
	class Lite
		class API < ContextIO::API::AbstractAPI

			VERSION = 'lite'

			def self.user_agent_string
				"contextio-#{self.version}-ruby-#{ContextIO.version}"
			end

			# @param [Object] resource The resource you want the URL for.
			#
			# @return [String] The URL for the resource in the API.
			def self.url_for(resource)
				ContextIO::Lite::URLBuilder.url_for(resource)
			end

			# @param [Object] resource The resource you want the URL for.
			#
			# @return [String] The URL for the resource in the API.
			def url_for(resource)
				ContextIO::Lite::API.url_for(resource)
			end

		end
	end
end