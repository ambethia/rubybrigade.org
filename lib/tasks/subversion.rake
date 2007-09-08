namespace :svn do

  desc "Configure a new project for subversion"
  task :configure do
    # FileUtils.cp 'config/database.yml', 'config/database.example.yml'
    # system "svn remove config/database.yml"
    # status "svn add config/database.example.yml"
    # system "svn propset svn:ignore 'database.yml' config"
    system "svn remove log/* --force"
    system "svn propset svn:ignore '*' log"
    system "svn remove tmp/* --force"
    system "svn propset svn:ignore '*' tmp"
    system "svn remove doc/* --force"
    system "svn propset svn:ignore '*' doc"
    FileUtils.chmod 0755, %w(log/ public/dispatch.rb public/dispatch.cgi public/dispatch.fcgi)
    system "svn propset svn:executable ON public/dispatch.* script/process/*"
  end
  
  desc "Add new files"
  task :add do
     system "svn status | grep '^\?' | sed -e 's/? *//' | sed -e 's/ /\ /g' | xargs svn add"
  end

  desc "Tell subversion to ignore coverage folders"
  task :coverage do
    FileUtils.remove_dir 'coverage', true
    system "svn remove coverage --force"
    system "svn propset svn:ignore 'coverage' ."
  end

end