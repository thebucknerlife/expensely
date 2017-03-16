namespace :batch do
  desc "Create Batch and Deliver"
  task create_and_deliver: :environment do
    los_angeles_day_of_week = Time.now.in_time_zone('America/Los_Angeles').wday
    return unless los_angeles_day_of_week == 1 # Monday

    Team.all.each do |team|
      CreateAndDeliverBatchService.new.run(
        team: team,
        requests: team.requests.includes(:user, request_items: :receipt)
      )
    end
  end
end
