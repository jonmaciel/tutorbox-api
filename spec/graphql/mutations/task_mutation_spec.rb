require 'rails_helper'

describe TaskMutation do
  describe TaskMutation::Create do  
    it { is_expected.to have_an_input_field(:name).of_type('String!') }
    it { is_expected.to have_an_input_field(:videoId).of_type('ID!') }
    it { is_expected.to have_a_return_field(:task).returning(Types::TaskType) }
  end

  describe TaskMutation::Update do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_an_input_field(:name).returning('String') }
    it { is_expected.to have_an_input_field(:done).returning('Boolean') }
    it { is_expected.to have_a_return_field(:task).returning(Types::TaskType) }
  end

  describe TaskMutation::Destroy do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_a_return_field(:success).returning('Boolean') }
  end
end
