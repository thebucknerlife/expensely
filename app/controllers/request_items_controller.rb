class RequestItemsController < ApplicationController

  def create
    @request_item = RequestItem.create!(request_item_params)
    render json: @request_item.as_json
  end

  private

  def request_item_params
    params.require(:request_item).permit(:description, :type, :amount, :request_id, :paid_at)
  end
end
