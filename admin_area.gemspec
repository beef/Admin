# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{admin_area}
  s.version = "0.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steve England"]
  s.date = %q{2009-09-07}
  s.email = %q{steve@wearebeef.co.uk}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "admin_area.gemspec",
     "app/controllers/admin/base_controller.rb",
     "app/controllers/admin/settings_controller.rb",
     "app/controllers/admin/users_controller.rb",
     "app/helpers/admin/base_helper.rb",
     "app/helpers/admin/settings_helper.rb",
     "app/helpers/admin/users_helper.rb",
     "app/models/settings.rb",
     "app/views/admin/base/index.html.erb",
     "app/views/admin/settings/_form.html.erb",
     "app/views/admin/settings/update.js.rjs",
     "app/views/admin/users/index.html.erb",
     "app/views/admin/users/show.html.erb",
     "app/views/layouts/admin.html.erb",
     "app/views/sessions/new.html.erb",
     "config/routes.rb",
     "generators/admin_area_files/USAGE",
     "generators/admin_area_files/admin_area_files_generator.rb",
     "generators/admin_area_files/lib/insert_commands.rb",
     "generators/admin_area_files/templates/app/models/content_sweeper.rb",
     "generators/admin_area_files/templates/app/views/admin/settings/show.html.erb",
     "generators/admin_area_files/templates/config/initializers/admin_area.rb",
     "generators/admin_area_files/templates/config/initializers/settings.rb",
     "generators/admin_area_files/templates/lib/tasks/admin_area.rake",
     "generators/admin_area_files/templates/migration.rb",
     "generators/admin_area_files/templates/public/images/admin/accept_button.gif",
     "generators/admin_area_files/templates/public/images/admin/add.png",
     "generators/admin_area_files/templates/public/images/admin/application_cascade.png",
     "generators/admin_area_files/templates/public/images/admin/arrow_down.gif",
     "generators/admin_area_files/templates/public/images/admin/arrow_left.gif",
     "generators/admin_area_files/templates/public/images/admin/arrow_right.gif",
     "generators/admin_area_files/templates/public/images/admin/arrow_up.gif",
     "generators/admin_area_files/templates/public/images/admin/button_bg.gif",
     "generators/admin_area_files/templates/public/images/admin/cancel_button.gif",
     "generators/admin_area_files/templates/public/images/admin/cursor_arrow.gif",
     "generators/admin_area_files/templates/public/images/admin/delete_button.gif",
     "generators/admin_area_files/templates/public/images/admin/down_icon.gif",
     "generators/admin_area_files/templates/public/images/admin/edit_button.gif",
     "generators/admin_area_files/templates/public/images/admin/file-uploads.png",
     "generators/admin_area_files/templates/public/images/admin/folder.png",
     "generators/admin_area_files/templates/public/images/admin/folder_image.png",
     "generators/admin_area_files/templates/public/images/admin/head_bg.gif",
     "generators/admin_area_files/templates/public/images/admin/image_add.png",
     "generators/admin_area_files/templates/public/images/admin/images-pointer.png",
     "generators/admin_area_files/templates/public/images/admin/info_bg.gif",
     "generators/admin_area_files/templates/public/images/admin/nav_bg.gif",
     "generators/admin_area_files/templates/public/images/admin/over_button_bg.gif",
     "generators/admin_area_files/templates/public/images/admin/page_bg.gif",
     "generators/admin_area_files/templates/public/images/admin/page_white.png",
     "generators/admin_area_files/templates/public/images/admin/page_white_get.png",
     "generators/admin_area_files/templates/public/images/admin/page_white_link.png",
     "generators/admin_area_files/templates/public/images/admin/page_white_stack.png",
     "generators/admin_area_files/templates/public/images/admin/picture.png",
     "generators/admin_area_files/templates/public/images/admin/picture_medium.png",
     "generators/admin_area_files/templates/public/images/admin/picture_square.png",
     "generators/admin_area_files/templates/public/images/admin/picture_thumb.png",
     "generators/admin_area_files/templates/public/images/admin/pictures.png",
     "generators/admin_area_files/templates/public/images/admin/sub_arrow_right.gif",
     "generators/admin_area_files/templates/public/images/admin/unapproved.png",
     "generators/admin_area_files/templates/public/images/admin/up_icon.gif",
     "generators/admin_area_files/templates/public/images/admin/zoom.gif",
     "generators/admin_area_files/templates/public/images/lightwindow/Thumbs.db",
     "generators/admin_area_files/templates/public/images/lightwindow/ajax-loading.gif",
     "generators/admin_area_files/templates/public/images/lightwindow/arrow-down.gif",
     "generators/admin_area_files/templates/public/images/lightwindow/arrow-up.gif",
     "generators/admin_area_files/templates/public/images/lightwindow/black-70.png",
     "generators/admin_area_files/templates/public/images/lightwindow/black.png",
     "generators/admin_area_files/templates/public/images/lightwindow/nextlabel.gif",
     "generators/admin_area_files/templates/public/images/lightwindow/pattern_148-70.png",
     "generators/admin_area_files/templates/public/images/lightwindow/pattern_148.gif",
     "generators/admin_area_files/templates/public/images/lightwindow/prevlabel.gif",
     "generators/admin_area_files/templates/public/images/textile-editor/background.png",
     "generators/admin_area_files/templates/public/images/textile-editor/blockquote.png",
     "generators/admin_area_files/templates/public/images/textile-editor/bold.png",
     "generators/admin_area_files/templates/public/images/textile-editor/center.png",
     "generators/admin_area_files/templates/public/images/textile-editor/h1.png",
     "generators/admin_area_files/templates/public/images/textile-editor/h2.png",
     "generators/admin_area_files/templates/public/images/textile-editor/h3.png",
     "generators/admin_area_files/templates/public/images/textile-editor/h4.png",
     "generators/admin_area_files/templates/public/images/textile-editor/h5.png",
     "generators/admin_area_files/templates/public/images/textile-editor/h6.png",
     "generators/admin_area_files/templates/public/images/textile-editor/indent.png",
     "generators/admin_area_files/templates/public/images/textile-editor/italic.png",
     "generators/admin_area_files/templates/public/images/textile-editor/justify.png",
     "generators/admin_area_files/templates/public/images/textile-editor/left.png",
     "generators/admin_area_files/templates/public/images/textile-editor/link.png",
     "generators/admin_area_files/templates/public/images/textile-editor/list_bullets.png",
     "generators/admin_area_files/templates/public/images/textile-editor/list_numbers.png",
     "generators/admin_area_files/templates/public/images/textile-editor/omega.png",
     "generators/admin_area_files/templates/public/images/textile-editor/outdent.png",
     "generators/admin_area_files/templates/public/images/textile-editor/paragraph.png",
     "generators/admin_area_files/templates/public/images/textile-editor/preview.png",
     "generators/admin_area_files/templates/public/images/textile-editor/right.png",
     "generators/admin_area_files/templates/public/images/textile-editor/strikethrough.png",
     "generators/admin_area_files/templates/public/images/textile-editor/underline.png",
     "generators/admin_area_files/templates/public/javascripts/admin/application.js",
     "generators/admin_area_files/templates/public/javascripts/lightwindow.js",
     "generators/admin_area_files/templates/public/javascripts/textile-editor-config.js",
     "generators/admin_area_files/templates/public/javascripts/textile-editor.js",
     "generators/admin_area_files/templates/public/stylesheets/admin/handheld.css",
     "generators/admin_area_files/templates/public/stylesheets/admin/ie.css",
     "generators/admin_area_files/templates/public/stylesheets/admin/print.css",
     "generators/admin_area_files/templates/public/stylesheets/admin/screen.css",
     "generators/admin_area_files/templates/public/stylesheets/admin/theme-1.0.css",
     "generators/admin_area_files/templates/public/stylesheets/lightwindow.css",
     "generators/admin_area_files/templates/public/stylesheets/textile-editor.css",
     "generators/admin_scaffold/USAGE",
     "generators/admin_scaffold/admin_scaffold_generator.rb",
     "generators/admin_scaffold/lib/insert_commands.rb",
     "generators/admin_scaffold/templates/admin_controller.rb",
     "generators/admin_scaffold/templates/admin_index.html.erb",
     "generators/admin_scaffold/templates/admin_show.html.erb",
     "generators/admin_scaffold/templates/helper.rb",
     "generators/admin_scaffold/templates/helper_test.rb",
     "generators/admin_scaffold/templates/layout.html.erb",
     "generators/admin_scaffold/templates/style.css",
     "generators/admin_scaffold/templates/view_controller.rb",
     "generators/admin_scaffold/templates/view_index.html.erb",
     "lib/admin_area.rb",
     "rails/init.rb",
     "test/admin_area_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/beef/admin}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Rails engine that provides a standard admin area with user managament}
  s.test_files = [
    "test/admin_area_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<thoughtbot-clearance>, [">= 0.6.6"])
      s.add_runtime_dependency(%q<thoughtbot-sortable_table>, [">= 0"])
      s.add_runtime_dependency(%q<mislav-will_paginate>, [">= 2.3.8"])
    else
      s.add_dependency(%q<thoughtbot-clearance>, [">= 0.6.6"])
      s.add_dependency(%q<thoughtbot-sortable_table>, [">= 0"])
      s.add_dependency(%q<mislav-will_paginate>, [">= 2.3.8"])
    end
  else
    s.add_dependency(%q<thoughtbot-clearance>, [">= 0.6.6"])
    s.add_dependency(%q<thoughtbot-sortable_table>, [">= 0"])
    s.add_dependency(%q<mislav-will_paginate>, [">= 2.3.8"])
  end
end
