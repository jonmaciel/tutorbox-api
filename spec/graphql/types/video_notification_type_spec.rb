require 'rails_helper'

describe Types::VideoNotificationType do
  it { is_expected.to have_field(:id).of_type('ID') }
  it { is_expected.to have_field(:body).of_type('String') }
  it { is_expected.to have_field(:read).of_type('Boolean') }
  it { is_expected.to have_field(:video).of_type('Video') }
  it { is_expected.to have_field(:user).of_type('User') }
end
