require 'rails_helper'

describe UserInput::Attributes do
  it { is_expected.to have_an_input_field(:name).of_type('String') }
  it { is_expected.to have_an_input_field(:email).of_type('String') }
  it { is_expected.to have_an_input_field(:cellphone).of_type('String') }
  it { is_expected.to have_an_input_field(:facebook_url).of_type('String') }
  it { is_expected.to have_an_input_field(:password).of_type('String') }
  it { is_expected.to have_an_input_field(:password_confirmation).of_type('String') }
  it { is_expected.to have_an_input_field(:user_role).of_type(MutationEnums::UserRoles) }
  it { is_expected.to have_an_input_field(:organization_id).of_type('ID') }
end
