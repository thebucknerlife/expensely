class RequestsController < ApplicationController

  def show
    request = Request.find(params[:id])
    @request_props = request.as_json(except: except_fields, include: { request_items: { except: except_fields }})
  end

  def update

  end

  private

  def except_fields
    [:created_at, :updated_at, :request_id]
  end
end
