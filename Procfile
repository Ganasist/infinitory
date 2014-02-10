web: rackup -p $PORT
worker: bundle exec sidekiq -q default -q mailer -q paperclip -c 2