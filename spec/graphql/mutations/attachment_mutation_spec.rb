require 'rails_helper'

describe AttachmentMutation do
  describe AttachmentMutation::Create do
    it { is_expected.to have_an_input_field(:name).of_type('String!') }
    it { is_expected.to have_an_input_field(:url).of_type('String!') }
    it { is_expected.to have_an_input_field(:sourceId).of_type('ID!') }
    it { is_expected.to have_a_return_field(:attachment).returning(Types::AttachmentType) }
  end

  describe AttachmentMutation::Destroy do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_a_return_field(:success).returning('Boolean') }
  end
end