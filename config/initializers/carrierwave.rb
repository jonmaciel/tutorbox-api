CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => "AWS",
    :region                 => 'us-east-1',
    aws_access_key_id: 'AKIAIYZDDECTXTMSGEDA',
    aws_secret_access_key: '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',
  }

  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end

  config.fog_directory  = 'tutorboxfiles'
  config.fog_public     = false
end
