require 'rails_helper'

describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:video) }
  end
end
