require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { is_expected.to act_as_paranoid }

  describe 'associations' do
    it { is_expected.to belong_to(:source) }
  end
end
