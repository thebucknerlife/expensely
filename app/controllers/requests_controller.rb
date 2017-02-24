require("#{Rails.root}/bots/expensely/utils/bot_client")

class RequestsController < ApplicationController
  http_basic_authenticate_with name: "expensely", password: "nicoleisthebest525", only: [:index, :download]

  before_action :get_request, only: [:show, :update]
  before_action :verify_token, only: [:show, :update]

  def show
    @request_props = @request.as_json(json_format)
  end

  def index
    decorate_requests
    render layout: "pdf"
  end

  def update
    @request.update(request_params)
    send_congrats if @request.submitted?

    render json: @request.as_json(json_format)
  end

  def download
    decorate_requests
    html = render_to_string(:action => :index, :layout => "pdf")
    pdf = WickedPdf.new.pdf_from_string(html)

    send_data(pdf,
              :filename => "requests-#{Time.now.strftime("%m-%e-%y-%H:%M:%S")}.pdf",
              :disposition => 'attachment')
  end

  private

  def get_request
    @request = Request.find_by(id: params[:id])
  end

  def send_congrats
    Expensely::Utils::BotClient.tell_user(@request.user, "Alright bestie, see you later!")
  end

  def verify_token
    render text: 'That reimbursement request is not available', status: :unauthorized unless @request && @request.token == params[:token]
  end

  def request_params
    params.require(:request).permit(:name, :submitted_at, request_items_attributes: [:id, :description, :category, :amount, :receipt_id, :_destroy])
  end

  def decorate_requests
    @decorated = RequestsByUserDecorator.decorate(Request.includes(:user, :request_items).all)
  end

  def json_format
    except = [:created_at, :updated_at, :request_id]
    {
      except: except, include: {
        request_items: { except: except, include: {
          receipt: { only: [:id], methods: [:url, :thumbnail_url, :accountant_url, :original_url] } }
        }
      }
    }
  end
end
