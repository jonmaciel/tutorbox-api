require 'rails_helper'

describe Types::S3Type do
  it { is_expected.to have_field(:signedUrl).of_type('String') }
  it { is_expected.to have_field(:fileName).of_type('String') }

end
