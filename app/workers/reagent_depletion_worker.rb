class ReagentDepletionWorker
  include Sidekiq::Worker
  sidekiq_options retry: true, backtrace: true

  def perform(reagent_id)
    reagent = Reagent.find(reagent_id)

    if reagent.location.present?
      reagent.users.each do |u|
        u.comments.create(comment: "#{ reagent.fullname } (#{ reagent.location }) had only #{ reagent.remaining }% remaining")
      end
      reagent.lab.comments.create(comment: "#{ reagent.fullname } (#{ reagent.location }) had only #{ reagent.remaining }% remaining")  
    else
      reagent.users.each do |u|
        u.comments.create(comment: "#{ reagent.fullname } had only #{ reagent.remaining }% remaining")
      end
      reagent.lab.comments.create(comment: "#{ reagent.fullname } had only #{ reagent.remaining }% remaining")
    end
  end
end