class User < ActiveRecord::Base
  include Clearance::User
  attr_accessible :name
  
  validates_presence_of :name
  
  # List of allowed roles
  ROLES = [:team_member, :admin]
  
  ROLES.each do |r|
    self.class_eval <<-RUBY
      def #{r}?
        authorised?(:#{r})
      end
    RUBY
  end
  
  def authorised?(*auth_roles)
    return false if role.blank?
    # Check the roles are real
    non_roles = auth_roles - ROLES
    unless non_roles.empty?
      raise ArgumentError, "No such role #{non_roles.join(', ')}"
    end
    auth_roles.include?(role.to_sym)
  end
end
