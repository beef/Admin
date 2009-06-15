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
end