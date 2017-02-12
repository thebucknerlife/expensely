class ReceiptsController < ApplicationController

  def create
   receipt = Receipt.create()
   render json: { id: receipt.id }
  end

  def update
   receipt = Receipt.find_by(id: params[:id])

   if receipt
    response = Cloudinary::Uploader.upload(params[:file], cloudinary_config)
    receipt.update(cloudinary_json: response)
    render json: receipt.as_json(only: [:id], methods: [:url, :thumbnail, :original_url])
   else
    render status: 400, head: :no_content
   end
  end

  private

  def cloudinary_config
    {
      cloud_name: ENV['CLOUDINARY_CLOUD_NAME'],
      api_key: ENV['CLOUDINARY_API_KEY'],
      api_secret: ENV['CLOUDINARY_API_SECRET']
    }
  end
end
