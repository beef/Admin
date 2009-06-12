class Admin::UsersController < Admin::BaseController
  sortable_attributes :name, :email, :role 

  # GET /users
  # GET /users.xml
  def index
    @users = User.paginate :page => params[:page], :per_page => 20, :order => sort_order

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
    render :action => 'show'
  end

  # GET /users/1/edit
  def show
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create    
    @user = User.new(params[:user])
    
    # Check that the current user has a sufficient access level to change new users access level. This is a secondary check to
    # protect against form tampering
    current_user.admin? ? @user.access_level_id = params[:user][:req_access_level] : @user.access_level_id = 3
    
    @user_image = @user.build_user_image(params[:user_image])
    @user_image.category = "User Images"
    @user_image.description = "#{@user.name}'s picture"

    respond_to do |format|
      if @user.save
        @user.confirm_email!
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(admin_users_url) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update  
    @user = User.find(params[:id])
    unless @user.user_image.nil?
      @user.user_image.update_attributes(params[:user_image])
    else
      @user_image = @user.build_user_image(params[:user_image])
      @user_image.category = "User Images"
      @user_image.description = "#{@user.name}'s picture"
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(admin_users_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
    end

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml  { head :ok }
    end
  end
  
end       
