require 'rails_helper'

describe Types::OrganizationType do
  it { is_expected.to have_field(:id).of_type('ID') }
  it { is_expected.to have_field(:name).of_type('String') }
  it { is_expected.to have_field(:users).of_type([Types::UserType]) }
  it { is_expected.to have_field(:created_at).of_type(Types::DateTimeType) }
  it { is_expected.to have_field(:updated_at).of_type(Types::DateTimeType) }
end
