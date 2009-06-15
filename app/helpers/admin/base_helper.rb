module Admin::BaseHelper
  
  def admin_page_title
    @page_title ||= controller.controller_name.titleize + (controller.action_name == 'index' ? ' ' : " #{controller.action_name.titleize}" )   
  end
  
  def tab(label, options = {}, roles = nil)
    return if roles and !current_user.authorised?(roles)
    content_tag :li, link_to(label, options)
  end
  
  def flash_messages
    flash.collect do |name, message|
      content_tag :div, message, :class => "flash #{name}"
    end.join
  end
  
  # RJS helper for flash text 
  def flash_messages_js(page, element = 'content-area')
    page.insert_html :before, element, flash_messages
    page << 'init_flash_messages();'
  end
  
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
  
  def preview_link(object)
    url = url_for([:preview, :admin, object ]) 
    "<a class='button' onclick=\"new Ajax.Updater('page_preview', '#{url}', {asynchronous:true, evalScripts:true, method:'get', parameters:'authenticity_token=' + encodeURIComponent('#{form_authenticity_token}') + $('content-node-form').serialize() + '&assets=' + getAssetIDs('asset-list')}); return false;\">Preview</a>"
  end
  
  def link_to_csv(text = 'Download CSV')
    params.delete(:page)
    link_to text, params.merge(:format => :csv)
  end

end
