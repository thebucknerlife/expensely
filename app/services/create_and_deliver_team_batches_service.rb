class CreateAndDeliverTeamBatchesService

  def run
    Team.all.each do |team|
      CreateAndDeliverBatchService.new.run(
        team: team,
        requests: to_be_delivered(team)
      )
    end
  end

  def to_be_delivered(team)
    Request.submitted.undelivered.where(user: team.user_ids)
  end
end
