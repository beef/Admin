namespace :admin_area do
  
  desc "Move create files"
  task :acts_as_content_node do
    system "rsync -ruv vendor/plugins/blogify/db/migrate db"
    system "rsync -ruv vendor/plugins/blogify/public ." 
  end
end