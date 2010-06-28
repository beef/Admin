ActionController::Routing::Routes.draw do |map|
  #Clearance::Routes.draw(map)
  
  map.admin 'admin', :controller => 'admin/base'
  map.namespace(:admin) do |admin|
    admin.resource :settings
    admin.resources :users
  end
end