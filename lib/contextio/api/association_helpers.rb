module ContextIO
  module API
    module AssociationHelpers
      def self.class_for_association_name(association_name)
        associations[association_name]
      end

      def self.register_resource(klass, association_name)
        associations[association_name] = klass
      end

      def self.associations
        @associations ||= {}
      end
    end
  end
end
