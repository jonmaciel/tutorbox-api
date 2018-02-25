require 'rails_helper'

describe Organization, type: :model do
  it { is_expected.to act_as_paranoid }

  describe 'associations' do
    it { is_expected.to have_many(:systems) }
    it { is_expected.to have_and_belong_to_many(:users) }
  end
end
