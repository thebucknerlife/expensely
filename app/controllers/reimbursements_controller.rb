class ReimbursementsController < ApplicationController
  def new
    @reimbursement_props = { name: "Stranger" }
  end
end
