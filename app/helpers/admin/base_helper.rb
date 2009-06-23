module Admin::BaseHelper
  include SortableTable::App::Helpers::ApplicationHelper
  
  def admin_menu_items
    tabs = Beef::AdminArea::ADMIN_MENU.map do | menu_item |
      if menu_item.is_a? Hash
        tab(menu_item[:title] || menu_item[:controller].to_s.titleize, send("admin_#{menu_item[:controller]}_path"), menu_item[:roles])
      else
        tab(menu_item.to_s.titleize, send("admin_#{menu_item}_path"))
      end
    end
    tabs.join
  end
  
  def admin_page_title
    @page_title ||= controller.controller_name.titleize + (controller.action_name == 'index' ? ' ' : " | #{controller.action_name.titleize}" )   
  end
  
  def tab(label, options = {}, roles = nil)
    return if roles and !current_user.authorised?(*roles)
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
    "<a class='button' onclick=\"new Ajax.Updater('page_preview', '#{url}', {asynchronous:true, evalScripts:true, parameters:'authenticity_token=' + encodeURIComponent('#{form_authenticity_token}') + this.up('form').serialize() + '&assets=' + getAssetIDs('asset-list')}); return false;\">Preview</a>"
  end

end
