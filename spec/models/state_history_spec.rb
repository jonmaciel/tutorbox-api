require 'rails_helper'

RSpec.describe StateHistory, type: :model do
  it { is_expected.to belong_to(:video) }
end
