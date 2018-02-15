require 'rails_helper'

describe UserRole, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:users) }
  end
end
