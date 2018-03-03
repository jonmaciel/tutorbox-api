require 'rails_helper'

describe Types::SystemType do
  it { is_expected.to have_field(:id).of_type('ID') }
  it { is_expected.to have_field(:name).of_type('String') }
  it { is_expected.to have_field(:videos).of_type([Types::VideoType]) }
end
