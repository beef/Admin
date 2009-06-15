namespace :admin_area do
  
  desc "Create an administrator User"
  task :create_admin_user do
    user = User.create :name => 'Administrator', :email => 'hello@wearebeef.co.uk', :password => 'passw0rd', :password_confirmation => 'passw0rd', :role => 'admin'
    user.confirm_email! if user.valid?
  end
end