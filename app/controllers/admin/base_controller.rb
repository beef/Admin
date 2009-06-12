class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  cache_sweeper :content_sweeper, :only => [ :create, :update, :destroy, :update_setting ]
  rescue_from Flickr::APIError, :with => :flickr_error
  
  def index
    @subscribers = Subscriber.find(:all).size
    @latest_comments = Comment.find(:all, :order => "created_at DESC", :limit => 3)
    @draft_articles = Article.drafts
  end
  
  def set_flickr_auth_token
    Flickr::connect Settings.flickr_api_key, Settings.flickr_api_secret
    Settings.flickr_auth_token = Flickr::API.authorise( params[:frob] )
    flash[:notice] = "Flickr API has been authorised"
    redirect_to :action => :index
  end
  
  def flickr 
    respond_to do |format|
      format.js
    end
  end

  protected
  
  def flickr_error
    flash[:notice] = "A Flickr error occured. Please check your flickr settings." 
    redirect_to :controller => 'admin/base', :action => 'index'
  end

end
