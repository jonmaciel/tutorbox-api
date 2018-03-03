require 'rails_helper'

describe Types::CommentType do
  it { is_expected.to have_field(:id).of_type('ID') }
  it { is_expected.to have_field(:author).of_type(Types::UserType) }
  it { is_expected.to have_field(:comment_destination).of_type('String') }
  it { is_expected.to have_field(:body).of_type('String') }
  it { is_expected.to have_field(:created_at).of_type(Types::DateTimeType) }
  it { is_expected.to have_field(:updated_at).of_type(Types::DateTimeType) }
end
