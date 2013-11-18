set :output, "#{path}/log/cron.log"

every 1.day do
  command "rm '#{path}/log/development.log'"
  command "rm '#{path}/log/test.log'"
  runner "PaperTrail::Version.delete_all['created_at < ?', 1.week.ago]"
end