namespace :batch do
  desc "Create Batch and Deliver"
  task create_and_deliver_now: :environment do
    Team.all.each do |team|
      log("Sending batch for Team #{team.id} (#{team.team_name})...")
      requests = team.requests.submitted.undelivered.includes(:user, request_items: :receipt)
      CreateAndDeliverBatchService.new.run(team: team)
      log("...done for request ids #{requests.ids}.")
    end
  end

  task create_and_deliver_monday: :environment do
    los_angeles_day_of_week = Time.now.in_time_zone('America/Los_Angeles').wday
    if los_angeles_day_of_week == 2 # Monday
      log("Sending batches on Monday...")
      Rake::Task['batch:create_and_deliver_now'].invoke
      log("...done sending Monday batches.")
    else
      log("Aborting as it is not Monday")
      abort
    end
  end
end

def log(msg)
  if Rails.env.development?
    puts("Rake Batch: #{msg}")
  else
    Rails.logger.info("Rake Batch: #{msg}")
  end
end
