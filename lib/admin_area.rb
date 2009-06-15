module AdminArea
  module Authorisation

    def self.included(controller)
      controller.send(:include, InstanceMethods)
      controller.extend ClassMethods

      controller.class_eval do
        helper_method :authorised?
        # helper_method :signed_in?
        
        hide_action :authorised?, :authorise
      end
    end
    
    module ClassMethods
      def authorise(options)
        raise ArgumentError, 'Roles must be suplied' if options[:roles].nil?
        before_filter :only => options[:only] do |controller|
          controller.authorise(*options[:roles])
        end
      end
    end

    module InstanceMethods
      def authorise(*roles)
        deny_access("You do not have the required access privelages to access page") unless current_user.authorised?(*roles)
      end
      
      def authorised?(*roles, &block)
        return unless current_user.authorised?(*roles)
        if block_given?
          yield
        else
          return true
        end 
      end
    end

  end
  
  module Roles

    def self.included(base)
      base.send(:include, InstanceMethods)

      base.class_eval do
        ROLES.each do |r|
          self.class_eval <<-RUBY
            def #{r}?
              authorised?(:#{r})
            end
          RUBY
        end
      end
    end

    module InstanceMethods
      def authorised?(*auth_roles)
        return false if role.blank?
        # Check the roles are real
        non_roles = auth_roles - User::ROLES
        unless non_roles.empty?
          raise ArgumentError, "No such role #{non_roles.join(', ')}"
        end
        auth_roles.include?(role.to_sym)
      end
    end

  end
end