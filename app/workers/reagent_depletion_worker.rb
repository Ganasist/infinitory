class ReagentDepletionWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

  def perform(reagent_id)
    reagent = Reagent.find(reagent_id)    
    comment = "#{ reagent.fullname } had only #{ reagent.remaining }% remaining"
    reagent.users.each do |u|
      u.comments.create(comment: comment)
    end
    reagent.lab.comments.create(comment: comment) 
  end
end