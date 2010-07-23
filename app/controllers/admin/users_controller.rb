class Admin::UsersController < Admin::BaseController
  authorise :roles => :admin
  sortable_attributes :name, :email, :role

  # GET /users
  # GET /users.xml
  def index
    conditions = []
    condition_params = []
    
    params[:search].each do |key,value|
      unless value.blank? || !User.new.respond_to?(key)
        conditions << "users.#{key.to_s} LIKE ?"
        condition_params << "%#{value}%"
      end
    end
      
    query_type = ' AND '
    query_type = ' OR ' if (params[:search][:query_type] || '') == 'any'
    
    @users = User.paginate :page => params[:page], :per_page => 20, :order => sort_order(:default => 'asc'), :conditions => condition_params.unshift(conditions.join(query_type))

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
    @user = User.new(params[:user]) do |user|
      # No need for email confirmation
      user.email_confirmed = true
      # Because mass assignment is protected
      user.role = params[:user][:role]
    end
    respond_to do |format|
      if @user.save
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
    # Because mass assignment is protected
    @user.role = params[:user].delete(:role)
    
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
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'User was successfully deleted.'

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml  { head :ok }
    end
  end

end
