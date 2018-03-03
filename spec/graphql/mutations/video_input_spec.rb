require 'rails_helper'

describe VideoInput::Attributes do
  it { is_expected.to have_an_input_field(:title).of_type('String') }
  it { is_expected.to have_an_input_field(:description).of_type('String') }
  it { is_expected.to have_an_input_field(:url).of_type('String') }
  it { is_expected.to have_an_input_field(:labels).of_type([String]) }
  it { is_expected.to have_an_input_field(:system_id).of_type('ID') }
end
