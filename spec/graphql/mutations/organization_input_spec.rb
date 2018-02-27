require 'rails_helper'

describe OrganizationInput::Attributes do
  it { is_expected.to have_an_input_field(:name).of_type('String') }
end
