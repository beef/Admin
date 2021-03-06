class Admin::BaseController < ApplicationController
  include Beef::AdminArea::Authorisation
  include SortableTable::App::Controllers::ApplicationController
  layout 'admin'
  before_filter :authenticate
  cache_sweeper :content_sweeper, :only => [ :create, :update, :destroy ]
  
end
