require 'rails_helper'

describe VideoMutation do
  describe VideoMutation::Create do
    it { is_expected.to have_an_input_field(:newVideoAttributes).of_type(!VideoInput::Attributes) }
    it { is_expected.to have_a_return_field(:video).returning(Types::VideoType) }
  end

  describe VideoMutation::Update do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_an_input_field(:videoAttributes).of_type(!VideoInput::Attributes) }
    it { is_expected.to have_a_return_field(:video).returning(Types::VideoType) }
  end

  describe VideoMutation::Destroy do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_a_return_field(:success).returning('Boolean') }
  end

  describe VideoMutation::ChangeState do
    it { is_expected.to have_an_input_field(:videoId).of_type('ID!') }
    it { is_expected.to have_an_input_field(:event).of_type('String!') }
    it { is_expected.to have_a_return_field(:success).returning('Boolean') }
  end

  describe '#callcheck' do
    let(:current_user) { users(:user_organization_admin) }
    let(:target_video) { videos(:default_video_2) }
    let(:target_user) { users(:user_video_producer) }
    let(:system) { systems(:default_system) }
    let(:organization) { organizations(:default_organization) }

    let(:result) {
      TutorboxApiSchema.execute(
        mutation,
        context: { current_user: current_user }
      )
    }
    describe '#create' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            createVideo(
              input: {
                newVideoAttributes: {
                  title: "Test",
                  description: "video test",
                  url: "fake_url",
                  labels: ["teste"],
                  system_id: #{system.id},
                }
              }
            ) {
              video { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the videos has been created' do
          it 'calls resolver and return video' do
            expect(Resolvers::Videos::Create).to receive(:call).and_call_original
            expect(result['data']['createVideo']['video']).to be_present
          end
        end
      end
    end

    describe '#update' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            updateVideo(
              input: {
                id: #{target_video.id},
                videoAttributes: {
                  title: "Test 2",
                  description: "video test 1",
                }
              }
            ) {
              video { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the video has been updated' do
          it 'calls resolver and return video' do
            expect(Resolvers::Videos::Update).to receive(:call).and_call_original
            expect(result['data']['updateVideo']['video']).to be_present
          end
        end
      end
    end

    describe '#destroy' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            destroyVideo(
              input: {
                id: #{target_video.id},
              }
            ) { success }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the video has been destroyed' do
          it 'calls resolver and return video' do
            expect(Resolvers::Videos::Destroy).to receive(:call).and_call_original
            expect(result['data']['destroyVideo']['success']).to be_truthy
          end
        end
      end
    end

    describe '#ChangeState' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            changeVideoState(
              input: {
                videoId: #{target_video.id},
                event: "cancel_video"
              }
            ) { success }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the video state has been changed' do
          it 'calls resolver and return video' do
            expect(Resolvers::Videos::ChangeState).to receive(:call).and_call_original
            expect(result['data']['changeVideoState']['success']).to be_truthy
          end
        end
      end
    end

    describe '#Assign' do
      let(:current_user) { users(:user_admin) }
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            assignVideo(
              input: {
                userId: #{target_user.id},
                videoId: #{target_video.id}
              }
            ) { success }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the video has been assigned' do
          it 'calls resolver and return video' do
            expect(Resolvers::Videos::Assign).to receive(:call).and_call_original
            expect(result['data']['assignVideo']['success']).to be_truthy
          end
        end
      end
    end

    describe '#Unassign' do
      let(:current_user) { users(:user_admin) }
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            unassignVideo(
              input: {
                userId: #{target_user.id},
                videoId: #{target_video.id}
              }
            ) { success }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the video has been unassigned' do
          it 'calls resolver and return video' do
            expect(Resolvers::Videos::Unassign).to receive(:call).and_call_original
            expect(result['data']['unassignVideo']['success']).to be_truthy
          end
        end
      end
    end
  end
end
