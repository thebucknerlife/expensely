class ReceiptsController < ApplicationController

  def create
   receipt = Receipt.create()
   render json: { id: receipt.id }
  end

  def update
   receipt = Receipt.find_by(id: params[:id])

   if receipt
    response = Cloudinary::Uploader.upload(params[:file], cloudinary_config.merge(public_id: receipt.cloudinary_public_id))
    filename = "#{response['public_id']}.#{response['format']}"
    receipt.update(cloudinary_json: response, filename: filename)
    render json: receipt.as_json(only: [:id], methods: [:url, :thumbnail_url, :accountant_url, :original_url])
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
