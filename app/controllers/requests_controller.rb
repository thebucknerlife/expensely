class RequestsController < ApplicationController
  before_action :get_request
  before_action :verify_token

  def show
    @request_props = @request.as_json(json_format)
  end

  def update
    @request.update(request_params)
    render json: @request.as_json(json_format)
  end

  private

  def get_request
    @request = Request.find_by(id: params[:id])
  end

  def verify_token
    render text: 'That reimbursement request is not available', status: :unauthorized unless @request && @request.token == params[:token]
  end

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
