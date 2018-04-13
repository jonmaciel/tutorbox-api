class UploadFileController < ApplicationController
  def create
    # In the controller
    options = { path_style: true }
    headers = { 'Content-Type' => 'text/plain;charset=UTF-8', 'x-amz-acl' => 'public-read' }

    url = storage.put_object_url('tutorbox-files', "user_uploads/#{params[:objectName]}", 15.minutes.from_now.to_time.to_i, headers, options)

    respond_to do |format|
      format.json { render json: { signedUrl: url } }
    end
  end

  private

  def storage
    storage ||= Fog::Storage.new(
      provider: 'AWS',
      aws_access_key_id: 'AKIAJPNKRN5S35O6XG6Q',
      aws_secret_access_key: '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'
    )
  end
end
