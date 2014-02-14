web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
web: rackup -p $PORT
worker: bundle exec sidekiq -q default -q mailer -q paperclip -c 2