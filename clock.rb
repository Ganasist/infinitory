# require 'clockwork'
# require 'sidekiq'
# require '../config/boot'
# require '../config/environment'

# module Clockwork
# 	handler do |job|
#     puts "Running #{job}"
#   end

#   every(1.minute, 'Reagent.expiration_notice')
# end