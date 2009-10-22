require 'clearance'
require 'will_paginate'
require 'sortable_table'
require 'admin_area'

config.after_initialize do
  # Put Clearance views at bottom of view paths
  path = ActionController::Base.view_paths.find { |p| p.to_s =~ /clearance/ }
  ActionController::Base.view_paths << ActionController::Base.view_paths.delete(path)
end 