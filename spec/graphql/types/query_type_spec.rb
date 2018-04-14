require 'rails_helper'

describe Types::QueryType do
  it { is_expected.to have_field(:organization).of_type(Types::OrganizationType) }
  it { is_expected.to have_field(:organizations).of_type([Types::OrganizationType]) }
  it { is_expected.to have_field(:assignedVideos).of_type([Types::VideoType]) }
  it { is_expected.to have_field(:selectMembers).of_type([Types::UserType]) }
end
