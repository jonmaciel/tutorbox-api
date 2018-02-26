require 'rails_helper'

describe Types::QueryType do
  it { is_expected.to have_field(:organization).of_type(Types::OrganizationType) }
end
