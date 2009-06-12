module Admin::BaseHelper
  
  def article_status(article)
    if article.published_at
      '<span class="status approved">Approved</span>'
    elsif article.published_at.nil?
      '<span class="status draft">Draft</span>'
    else
      '<span class="status hidden">Hidden</span>'
    end
  end
  
  def lastest_flickr
    return if Settings.flickr_api_key.blank? or Settings.flickr_user_id.blank?
    Flickr::API.connect Settings.flickr_api_key, Settings.flickr_api_secret, Settings.flickr_auth_token
    flickr_params = { :per_page => '5', :page => params[:page], :user_id => Settings.flickr_user_id, :sort => 'date-taken-desc', :tag_mode => 'all' }
    flickr_params[:tags] = params[:tags] unless params[:tags].blank?
    flickr_result = Flickr::Photo.find(:all, flickr_params)
    render :partial => 'admin/shared/flickr_latest.html.erb', :locals => { :flickr_images => flickr_result }
  end
  
  
  def flickr_select
    return if Settings.flickr_api_key.blank? or Settings.flickr_user_id.blank?
    Flickr::API.connect Settings.flickr_api_key, Settings.flickr_api_secret, Settings.flickr_auth_token
    flickr_params = { :per_page => '12', :page => params[:page], :user_id => Settings.flickr_user_id, :sort => 'date-taken-desc', :tag_mode => 'all' }
    flickr_params[:tags] = params[:tags] unless params[:tags].blank?
    flickr_result = Flickr::Photo.find(:all, flickr_params)
    render :partial => 'admin/shared/flickr.html.erb', :locals => { :flickr_images => flickr_result }
  end
  
  def link_to_sort(text, options = nil, html_options = nil)
    orders = ['ASC','DESC']
    
    if options.nil? || options[:sort].nil?
      options = (options || {}).merge({:sort => text.downcase.gsub(' ','_')}) 
    end
    
    #switch the order if we are sorting by this column
    if options[:sort] == params[:sort]
      order = orders[ (orders.index(params[:order]).to_i + 1) % 2 ]
    else
      #default
      order = orders.first
    end
    
    link_to text, {:page => 1}.merge(options).merge(params.reject{|key, value| key == 'sort' || key == 'order'} || {}).merge({:sort => options[:sort], :order => order}), html_options
  end

  def preview_link(object)
    url = url_for([:preview, :admin, object ]) 
    "<a class='button' onclick=\"new Ajax.Updater('page_preview', '#{url}', {asynchronous:true, evalScripts:true, method:'get', parameters:'authenticity_token=' + encodeURIComponent('#{form_authenticity_token}') + $('content-node-form').serialize() + '&assets=' + getAssetIDs('asset-list')}); return false;\">Preview</a>"
  end
  
  def link_to_csv(text = 'Download CSV')
    params.delete(:page)
    link_to text, params.merge(:format => :csv)
  end

end
