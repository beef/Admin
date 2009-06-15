module Admin::SettingsHelper
  def setting_form(settings=[])
    if settings.is_a? String
      settings = [[settings,'text']]
    end
    render :partial => 'admin/settings/form', :locals => { :settings => settings }
  end
end
