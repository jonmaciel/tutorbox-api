require 'rails_helper'

describe Video, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:system) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:tasks) }
    it { is_expected.to have_many(:attachments) }
  end

  describe '#aasm' do

  end
end
