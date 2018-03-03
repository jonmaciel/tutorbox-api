require 'rails_helper'

RSpec.describe System, type: :model do
  it { is_expected.to act_as_paranoid }

  describe 'associations' do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to have_many(:attachments) }
    it { is_expected.to have_many(:videos) }
  end
end
