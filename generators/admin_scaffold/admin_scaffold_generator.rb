require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")

class AdminScaffoldGenerator < ScaffoldGenerator
  
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions("#{controller_class_name}Controller", "Admin::#{controller_class_name}Controller")
      m.class_collisions(class_name)

      # Controller, views, test and stylesheets directories.
      m.directory(File.join('spec','factories'))
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/controllers/admin', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.directory(File.join('app/views/admin', controller_class_path, controller_file_name))
      m.directory(File.join('app/views/layouts', controller_class_path))
      m.directory(File.join('public/stylesheets', class_path))

      for action in ['index', 'show']
        m.template(
          "admin_#{action}.html.erb",
          File.join('app/views/admin', controller_class_path, controller_file_name, "#{action}.html.erb")
        )
      end
      
      m.template(
        "view_index.html.erb",
        File.join('app/views', controller_class_path, controller_file_name, "index.html.erb")
      )
      m.template(
        'view_controller.rb', File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      )
      m.template(
        'admin_controller.rb', File.join('app/controllers/admin', controller_class_path, "#{controller_file_name}_controller.rb")
      )
      m.template(
        'factory.rb', File.join('spec','factories', "#{singular_name}.rb")
      )

      m.route_resources controller_file_name
      m.route_resources_to_namespace('admin', controller_file_name)
      
      m.dependency 'rpec_controller', [controller_file_name, 'index'], :collision => :skip
      m.dependency 'rpec_controller', ["admin/#{controller_file_name}", 'index', 'show'], :collision => :skip
      m.dependency 'rpec_model', [name, '--skip-fixture'] + @args, :collision => :skip
    end
  end

end
