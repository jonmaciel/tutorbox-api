require 'rails_helper'

describe Types::UserType do
  it { is_expected.to have_field(:id).of_type('ID') }
  it { is_expected.to have_field(:name).of_type('String') }
  it { is_expected.to have_field(:email).of_type('String') }
  it { is_expected.to have_field(:cellphone).of_type('String') }
  it { is_expected.to have_field(:facebook_url).of_type('String') }
  it { is_expected.to have_field(:user_role).of_type('String') }
  it { is_expected.to have_field(:videoNotifications).of_type([Types::VideoNotificationType]) }
  it { is_expected.to have_field(:created_at).of_type(Types::DateTimeType) }
  it { is_expected.to have_field(:updated_at).of_type(Types::DateTimeType) }
end
