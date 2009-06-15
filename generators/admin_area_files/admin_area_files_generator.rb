require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")

class AdminAreaFilesGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      
      m.dependency 'clearance', []
      
      m.press_any_key
      
      m.insert_into 'app/models/user.rb', <<-RUBY
include Admin::Roles
  attr_accessible :name

  validates_presence_of :name

  # List of allowed roles. Removing admin role will cause errors
  ROLES = [:team_member, :admin]
RUBY
      
      
      m.directory File.join("public", "images", "admin")
      m.directory File.join("public", "images", "textile-editor")
      m.directory File.join("public", "javascripts", "admin")
      m.directory File.join("public", "stylesheets", "admin")
      
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
      "public/stylesheets/admin/handheld.css",
      "public/stylesheets/admin/ie.css",
      "public/stylesheets/admin/print.css",
      "public/stylesheets/admin/screen.css",
      "public/stylesheets/admin/theme-1.0.css",
      "app/models/content_sweeper.rb"].each do |file|
        m.file file, file
       end
       
       m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => 'create_settings_and_users'
       
    end
  end
end
