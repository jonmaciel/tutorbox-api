require 'rails_helper'

describe User, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user_role) }
    it { is_expected.to have_and_belong_to_many(:organizations) }
    it { is_expected.to have_many(:videos) }
  end
end
