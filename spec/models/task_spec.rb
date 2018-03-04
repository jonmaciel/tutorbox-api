require 'rails_helper'

describe Task, type: :model do
  it { is_expected.to act_as_paranoid }

  describe 'associations' do
    it { is_expected.to belong_to(:video) }
    it { is_expected.to belong_to(:created_by) }
  end
end
