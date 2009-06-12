class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  cache_sweeper :content_sweeper, :only => [ :create, :update, :destroy ]
  
end
