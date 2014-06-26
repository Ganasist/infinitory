class ReagentDepletionWorker
  include Sidekiq::Worker
  sidekiq_options retry: true, backtrace: true

  def perform(reagent_id)
    reagent = Reagent.find(reagent_id)    
    
    if reagent.location.present?
      comment = "#{ reagent.fullname } (#{ reagent.location }) had only #{ reagent.remaining }% remaining"
    else
      comment = "#{ reagent.fullname } had only #{ reagent.remaining }% remaining"
    end
    reagent.users.each do |u|
      u.comments.create(comment: comment)
    end
    reagent.lab.comments.create(comment: comment) 
  end
end