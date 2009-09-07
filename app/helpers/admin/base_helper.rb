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
  
  def preview_link(object)
    url = url_for([:preview, :admin, object ])
    link_to_function 'Preview', "new Ajax.Updater('page_preview', '#{url}', {asynchronous:true, evalScripts:true, parameters: this.up('form').serialize() + '&assets=' + getAssetIDs('asset-list')})", :class => 'button' 
  end

end
