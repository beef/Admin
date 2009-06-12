require File.expand_path(File.dirname(__FILE__) + "/lib/insert_commands.rb")

class ContentNodeScaffoldGenerator < ScaffoldGenerator
  
  def initialize(runtime_args, runtime_options = {})
    super

    @args = ['title:string', 'permalink:string', 'published_at:datetime', 'published_to:datetime'] + @args
  end
  
  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions("#{controller_class_name}Controller", "Admin::#{controller_class_name}Controller", "#{controller_class_name}Helper")
      m.class_collisions(class_name)

      # Controller, helper, views, test and stylesheets directories.
      m.directory(File.join('app/models', class_path))
      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/controllers/admin', controller_class_path))
      m.directory(File.join('app/helpers', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.directory(File.join('app/views/admin', controller_class_path, controller_file_name))
      m.directory(File.join('app/views/layouts', controller_class_path))
      m.directory(File.join('test/unit', class_path))
      m.directory(File.join('test/unit/helpers', class_path))
      m.directory(File.join('public/stylesheets', class_path))

      for action in ['index', 'show']
        m.template(
          "view_#{action}.html.erb",
          File.join('app/views', controller_class_path, controller_file_name, "#{action}.html.erb")
        )
        m.template(
          "admin_#{action}.html.erb",
          File.join('app/views/admin', controller_class_path, controller_file_name, "#{action}.html.erb")
        )
      end

      # Layout and stylesheet.
      m.template('layout.html.erb', File.join('app/views/layouts', controller_class_path, "application.html.erb"))
      m.template('style.css', 'public/stylesheets/scaffold.css')

      m.template(
        'view_controller.rb', File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      )
      m.template(
        'admin_controller.rb', File.join('app/controllers/admin', controller_class_path, "#{controller_file_name}_controller.rb")
      )

      m.template('helper.rb',          File.join('app/helpers',     controller_class_path, "#{controller_file_name}_helper.rb"))
      m.template('helper_test.rb',     File.join('test/unit/helpers',    controller_class_path, "#{controller_file_name}_helper_test.rb"))

      m.route_resources controller_file_name
      m.route_resources_to_namespace('admin', controller_file_name)

      m.dependency 'model', [name] + @args, :collision => :skip
    end
  end

end
