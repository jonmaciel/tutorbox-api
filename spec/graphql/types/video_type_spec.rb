require 'rails_helper'

describe Types::VideoType do
  it { is_expected.to have_field(:id).of_type('ID') }
  it { is_expected.to have_field(:title).of_type('String') }
  it { is_expected.to have_field(:description).of_type('String') }
  it { is_expected.to have_field(:script).of_type('String') }
  it { is_expected.to have_field(:url).of_type('String') }
  it { is_expected.to have_field(:version).of_type('String') }
  it { is_expected.to have_field(:revised_by_custumer).of_type('Boolean') }
  it { is_expected.to have_field(:aasm_state).of_type('String') }
  it { is_expected.to have_field(:labels).of_type([String]) }
  it { is_expected.to have_field(:created_by).of_type(Types::UserType) }
  it { is_expected.to have_field(:users).of_type([Types::UserType]) }
  it { is_expected.to have_field(:tasks).of_type([Types::TaskType]) }
  it { is_expected.to have_field(:comments).of_type([Types::CommentType]) }
  it { is_expected.to have_field(:system).of_type(Types::SystemType) }
  it { is_expected.to have_field(:permited_events).of_type([String]) }
  it { is_expected.to have_field(:created_at).of_type(Types::DateTimeType) }
  it { is_expected.to have_field(:updated_at).of_type(Types::DateTimeType) }
end
