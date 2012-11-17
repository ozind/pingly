namespace :admin do
  task :run_d => :environment do
    system("#{Rails.root}/lib/daemons/poller_ctl run")
  end
end