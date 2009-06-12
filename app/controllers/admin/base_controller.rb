class Admin::BaseController < ApplicationController
  include Clearance::Authentication
  layout 'admin'
  before_filter :authenticate
  cache_sweeper :content_sweeper, :only => [ :create, :update, :destroy ]
  
end
