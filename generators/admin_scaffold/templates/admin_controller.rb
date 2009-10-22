class Admin::<%= controller_class_name %>Controller < Admin::BaseController
  sortable_attributes :created_at, :updated_at, :<%= attributes.collect{|a| a.name}.join(', :') %> 

  def index
    @<%= table_name %> = <%= class_name %>.paginate :page => params[:page], :order => sort_order

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= table_name %> }
    end
  end

  def show
    @<%= file_name %> = <%= class_name %>.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @<%= file_name %> }
    end
  end

  def new
    @<%= file_name %> = <%= class_name %>.new

    respond_to do |format|
      format.html { render :action =>'show' }
      format.xml  { render :xml => @<%= file_name %> }
    end
  end

  def create
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])

    respond_to do |format|
      if @<%= file_name %>.save
        flash[:notice] = '<%= class_name %> was successfully created.'
        format.html { redirect_to(admin_<%= table_name %>_url) }
        format.xml  { render :xml => @<%= file_name %>, :status => :created, :location => @<%= file_name %> }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @<%= file_name %> = <%= class_name %>.find(params[:id])

    respond_to do |format|
      if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
        flash[:notice] = '<%= class_name %> was successfully updated.'
        format.html { redirect_to(admin_<%= table_name %>_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @<%= file_name %>.destroy
    flash[:notice] = '<%= class_name %> was successfully deleted.'

    respond_to do |format|
      format.html { redirect_to(admin_<%= table_name %>_url) }
      format.xml  { head :ok }
    end
  end
end
