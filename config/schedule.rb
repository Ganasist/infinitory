set :output, "#{path}/log/cron.log"
set :environment, 'development'

every 1.day, at: '15:00' do
  command "rm '#{path}/log/development.log'"
  command "rm '#{path}/log/test.log'"
  runner "PaperTrail::Version.delete_all['created_at < ?', 1.week.ago]"

  command "curl #{path}/errors/404 > public/404.html && curl #{path}/errors/403 > public/403.html && curl #{path}/errors/503 > public/503.html"
end