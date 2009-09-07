class Admin::SettingsController < Admin::BaseController

  def show
    unless current_user.admin?
      flash.now[:notice] = 'You may view settings but editing is only available to Adminstrators.'
    end
    @settings = Settings
  end

  def update
    unless current_user.admin?
      flash[:notice] = 'You may view settings but editing is only available to Adminstrators.'
    else
      params[:settings].each_pair do |key,value|
        Settings[key] = value.strip
      end
  
      flash.now[:notice] = "Setting#{params[:settings].length>1?'s':''} #{params[:settings].collect{|s,v| s.humanize}.join(', ')} was successfully updated."
    end
    
    respond_to do |format|
      format.html { redirect_to admin_setting_path}
      format.js
    end
  end

end
