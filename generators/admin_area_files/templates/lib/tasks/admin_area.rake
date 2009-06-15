namespace :admin_area do
  
  desc "Create an administrator User"
  task :create_admin_user => :environment do
    user = User.new :name => 'Administrator', :email => 'hello@wearebeef.co.uk', :password => 'passw0rd', :password_confirmation => 'passw0rd'
    user.role = 'admin'
    user.save
    user.confirm_email! if user.valid?
  end
end