class Admin::SettingsController < Admin::BaseController

  # rescue_from Flickr::APIError, :with => :flickr_error
  
  def show
    unless current_user.admin?
      flash.now[:notice] = 'You may view settings but editing is only available to Adminstrators.'
    end
    
    @settings = Settings

    # unless Settings.flickr_api_key.blank? or Settings.flickr_api_secret.blank?
    #   Flickr::API.connect Settings.flickr_api_key, Settings.flickr_api_secret, Settings.flickr_auth_token
    #   if @unauthorised = Flickr::API.unauthorised?
    #     @login_url = Flickr::API.login_url
    #   end
    # end
  end

  def update
    unless current_user.admin?
      flash[:notice] = 'You may view settings but editing is only available to Adminstrators.'
    else
  
      params[:settings].each_pair do |key,value|
        if(key =~ /(_api_key|_api_secret)/i)
          value.strip!
        end
        
        Settings[key] = value.gsub(/^http\:\/\//i,'')
      end
  
      flash.now[:notice] = "Setting#{params[:settings].length>1?'s':''} #{params[:settings].collect{|s,v| s.humanize}.join(', ')} was successfully updated."
    end
    
    respond_to do |format|
      format.html { redirect_to admin_setting_path}
      format.js
    end

  end

end
