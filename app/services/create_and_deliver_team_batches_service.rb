class CreateAndDeliverTeamBatchesService

  def run
    Team.all.each do |team|
      CreateAndDeliverBatchService.new.run(team: team)
    end
  end
end
