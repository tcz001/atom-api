module API
  class Galleries < Grape::API
    formatter :json, API::Formatter.normal
    error_formatter :json, API::Formatter.error
    helpers SharedParams

    desc 'upload a pic' do
      headers Authorization: {
                  description: 'Check Galleries Admin Authorization: \'Bearer token\'',
                  required: true
              }
    end
    params do
      requires :image_file, type: File, desc: 'image file.'
      requires :imageable_type, type: String, desc: 'imageable type can be [Game,...]'
      requires :imageable_id, type: Integer, desc: 'imageable id is the id of object (etc, Game id).'
    end
    post "upload" do
      begin
        doorkeeper_authorize!
        image = Image.create(file: params[:image_file].tempfile,imageable_type: params[:imageable_type],imageable_id: params[:imageable_id])
        present image, with: API::Entities::Image
      rescue Exception => e
        logger.error e
        error!({error: 'unexpected error', detail: 'external image service error'}, 500)
      end
    end
  end
end