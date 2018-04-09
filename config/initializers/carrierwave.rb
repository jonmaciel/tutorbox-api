CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => "AWS",
    :region                 => 'us-east-2',
    :aws_access_key_id      => 'AKIAJPNKRN5S35O6XG6Q',
    :aws_secret_access_key  => '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'
  }

  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end

  config.fog_directory  = 'tutorbox-files'
  config.fog_public     = false
end
