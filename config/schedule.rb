set :output, "#{path}/log/cron.log"
set :environment, 'development'

every 1.day, at: '15:00' do
  command "rm '#{path}/log/development.log'"
  command "rm '#{path}/log/test.log'"
  runner "PaperTrail::Version.delete_all['created_at < ?', 1.week.ago]"
end