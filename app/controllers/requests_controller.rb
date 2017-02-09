class RequestsController < ApplicationController

  def show
    request = Request.find(params[:id])
    @request_props = request.as_json(json_format)
  end

  def update
    request = Request.find(params[:id])
    request.update(request_params)
    render json: request.as_json(json_format)
  end

  private

  def request_params
    params.require(:request).permit(:name, :submitted_at, request_items_attributes: [:id, :description, :category, :amount, :receipt_id, :_destroy])
  end

  def json_format
    except = [:created_at, :updated_at, :request_id]
    {
      except: except, include: {
        request_items: { except: except, include: {
          receipt: { only: [:id], methods: [:url] } }
        }
      }
    }
  end
end
