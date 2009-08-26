require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")

class AdminAreaFilesGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      
      m.insert_into 'app/models/user.rb', <<-RUBY
# List of allowed roles. Removing admin role will cause errors
  ROLES = [:team_member, :admin]
  include Beef::AdminArea::Roles
  
  attr_accessible :name
  validates_presence_of :name
  
private
  before_save :set_permalink

  def set_permalink
    self.permalink = name.parameterize
  end
RUBY
      
      
      m.directory File.join("public", "images", "admin")
      m.directory File.join("public", "images", "textile-editor")
      m.directory File.join("public", "images", "lightwindow")
      m.directory File.join("public", "javascripts", "admin")
      m.directory File.join("public", "stylesheets", "admin")
      m.directory File.join("lib", "tasks")
      m.directory File.join("app", "views", "admin", "settings")
      
      ["public/images/admin/accept_button.gif",
      "public/images/admin/add.png",
      "public/images/admin/application_cascade.png",
      "public/images/admin/arrow_left.gif",
      "public/images/admin/arrow_right.gif",
      "public/images/admin/button_bg.gif",
      "public/images/admin/cancel_button.gif",
      "public/images/admin/cursor_arrow.gif",
      "public/images/admin/delete_button.gif",
      "public/images/admin/down_icon.gif",
      "public/images/admin/edit_button.gif",
      "public/images/admin/file-uploads.png",
      "public/images/admin/folder.png",
      "public/images/admin/folder_image.png",
      "public/images/admin/head_bg.gif",
      "public/images/admin/image_add.png",
      "public/images/admin/images-pointer.png",
      "public/images/admin/info_bg.gif",
      "public/images/admin/nav_bg.gif",
      "public/images/admin/over_button_bg.gif",
      "public/images/admin/page_bg.gif",
      "public/images/admin/page_white.png",
      "public/images/admin/page_white_get.png",
      "public/images/admin/page_white_link.png",
      "public/images/admin/page_white_stack.png",
      "public/images/admin/picture.png",
      "public/images/admin/picture_medium.png",
      "public/images/admin/picture_square.png",
      "public/images/admin/picture_thumb.png",
      "public/images/admin/pictures.png",
      "public/images/admin/unapproved.png",
      "public/images/admin/up_icon.gif",
      "public/images/admin/arrow_down.gif",
      "public/images/admin/arrow_up.gif",
      "public/images/admin/sub_arrow_right.gif",
      "public/images/admin/zoom.gif",
      "public/images/lightwindow/ajax-loading.gif",
      "public/images/lightwindow/arrow-down.gif",
      "public/images/lightwindow/arrow-up.gif",
      "public/images/lightwindow/black-70.png",
      "public/images/lightwindow/black.png",
      "public/images/lightwindow/nextlabel.gif",
      "public/images/lightwindow/pattern_148-70.png",
      "public/images/lightwindow/pattern_148.gif",
      "public/images/lightwindow/prevlabel.gif",
      "public/images/textile-editor/background.png",
      "public/images/textile-editor/blockquote.png",
      "public/images/textile-editor/bold.png",
      "public/images/textile-editor/center.png",
      "public/images/textile-editor/h1.png",
      "public/images/textile-editor/h2.png",
      "public/images/textile-editor/h3.png",
      "public/images/textile-editor/h4.png",
      "public/images/textile-editor/h5.png",
      "public/images/textile-editor/h6.png",
      "public/images/textile-editor/indent.png",
      "public/images/textile-editor/italic.png",
      "public/images/textile-editor/justify.png",
      "public/images/textile-editor/left.png",
      "public/images/textile-editor/link.png",
      "public/images/textile-editor/list_bullets.png",
      "public/images/textile-editor/list_numbers.png",
      "public/images/textile-editor/omega.png",
      "public/images/textile-editor/outdent.png",
      "public/images/textile-editor/paragraph.png",
      "public/images/textile-editor/preview.png",
      "public/images/textile-editor/right.png",
      "public/images/textile-editor/strikethrough.png",
      "public/images/textile-editor/underline.png",
      "public/javascripts/admin/application.js",
      "public/javascripts/lightwindow.js",
      "public/javascripts/textile-editor-config.js",
      "public/javascripts/textile-editor.js",
      "public/stylesheets/admin/handheld.css",
      "public/stylesheets/admin/ie.css",
      "public/stylesheets/admin/print.css",
      "public/stylesheets/admin/screen.css",
      "public/stylesheets/admin/theme-1.0.css",
      "public/stylesheets/lightwindow.css",
      "public/stylesheets/textile-editor.css",
      "app/models/content_sweeper.rb",
      "lib/tasks/admin_area.rake",
      "config/initializers/settings.rb",
      "config/initializers/admin_area.rb",
      "app/views/admin/settings/show.html.erb"].each do |file|
         m.file file, file
       end
       
       m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => 'create_settings_and_users'
       
    end
  end
end
