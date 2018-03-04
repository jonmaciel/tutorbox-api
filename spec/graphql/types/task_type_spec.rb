require 'rails_helper'

describe Types::TaskType do
  it { is_expected.to have_field(:id).of_type('ID') }
  it { is_expected.to have_field(:name).of_type('String') }
  it { is_expected.to have_field(:done).of_type('Boolean') }
  it { is_expected.to have_field(:created_by).of_type(Types::UserType) }
end
