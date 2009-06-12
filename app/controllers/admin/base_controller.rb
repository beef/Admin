class Admin::BaseController < ApplicationController
  include Clearance::Authentication
  include SortableTable::App::Controllers::ApplicationController
  layout 'admin'
  before_filter :authenticate
  cache_sweeper :content_sweeper, :only => [ :create, :update, :destroy ]
  
end
