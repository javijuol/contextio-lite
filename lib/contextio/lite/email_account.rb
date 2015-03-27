require 'contextio/api/resource'
require 'contextio/api/association_helpers'

module ContextIO
	class Lite
		class EmailAccount
			include ContextIO::API::Resource

			self.primary_key = :label
			self.association_name = :email_account

			has_many :folders

			lazy_attributes :server, :label, :username, :port, :authentication_type,
			                :status, :service_level, :sync_period, :use_ssl, :type
			private :use_ssl

			# @!attribute [r] use_ssl?
			#   @return [Boolean] Whether or not this source uses SSL.
			def use_ssl?
				use_ssl
			end

			# Updates the email_account.
			#
			# @params [Hash{String, Symbol => String}] options See the Context.IO docs
			#   for more details on these fields.
			def update(options={})
				it_worked = api.request(:post, resource_url, options)['success']

				if it_worked
					options.each do |key, value|
						key = key.to_s.gsub('-', '_')

						instance_variable_set("@#{key}", value)
					end
				end

				it_worked
			end

			def delete
				api.request(:delete, resource_url)['success']
			end

		end
	end
end