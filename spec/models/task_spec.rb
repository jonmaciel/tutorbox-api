require 'rails_helper'

describe Task, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:video) }
  end
end
