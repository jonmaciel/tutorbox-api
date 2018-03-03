require 'rails_helper'

describe Types::VideoType do
  it { is_expected.to have_field(:id).of_type('ID') }
  it { is_expected.to have_field(:title).of_type('String') }
  it { is_expected.to have_field(:url).of_type('String') }
  it { is_expected.to have_field(:aasm_state).of_type('String') }
  it { is_expected.to have_field(:labels).of_type([String]) }
  it { is_expected.to have_field(:created_by).of_type(Types::UserType) }
  it { is_expected.to have_field(:comments).of_type([Types::CommentType]) }
  it { is_expected.to have_field(:permited_events).of_type([String]) }
  it { is_expected.to have_field(:created_at).of_type(Types::DateTimeType) }
  it { is_expected.to have_field(:updated_at).of_type(Types::DateTimeType) }
end
