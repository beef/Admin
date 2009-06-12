ActionController::Routing::Routes.draw do |map|
  map.logout 'logout', :controller => 'clearance/sessions', :action => 'destroy'
  map.admin 'admin', :controller => 'admin/base'
  map.namespace(:admin) do |admin|
    admin.flickr 'flickr', :controller => 'base', :action => 'flickr'
    admin.resources :settings, :collection => {:update_set => :post}, :id => nil
    admin.resources :users
  end
end