ActionController::Routing::Routes.draw do |map|
  map.admin 'admin', :controller => 'admin/base'
  map.namespace(:admin) do |admin|
    admin.flickr 'flickr', :controller => 'base', :action => 'flickr'
    admin.resource :settings
    admin.resources :users
  end
end