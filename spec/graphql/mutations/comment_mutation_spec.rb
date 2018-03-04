require 'rails_helper'

describe CommentMutation do
  describe CommentMutation::Post do
    it { is_expected.to have_an_input_field(:commentDestination).of_type(!MutationEnums::CommentDestinations) }
    it { is_expected.to have_an_input_field(:body).of_type('String!') }
    it { is_expected.to have_an_input_field(:videoId).of_type('ID!') }
    it { is_expected.to have_a_return_field(:comment).returning(Types::CommentType) }
  end

  describe CommentMutation::Edit do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_an_input_field(:body).returning('String') }
    it { is_expected.to have_an_input_field(:read).returning('Boolean') }
    it { is_expected.to have_a_return_field(:comment).returning(Types::CommentType) }
  end

  describe CommentMutation::Destroy do
    it { is_expected.to have_an_input_field(:id).of_type('ID!') }
    it { is_expected.to have_a_return_field(:success).returning('Boolean') }
  end

 describe '#callcheck' do
    let(:current_user) { users(:user_organization_admin) }
    let(:target_video) { videos(:default_video_2) }
    let(:target_comment) { comments(:comment_default_video_1) }

    let(:result) {
      TutorboxApiSchema.execute(
        mutation,
        context: { current_user: current_user }
      )
    }

    describe '#post' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            postComment(
              input: {
                body: "new commentarie",
                videoId: #{target_video.id},
                commentDestination: administrative,
              }
            ) {
              comment { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the comment has been created' do
          it 'calls resolver and return comment' do
            expect(Resolvers::Comments::Post).to receive(:call).and_call_original
            expect(result['data']['postComment']['comment']).to be_present
          end
        end
      end
    end

    describe '#edit' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            editComment(
              input: {
                id: #{target_comment.id},
                body: "edited commentarie",
                read: true,
              }
            ) {
              comment { id }
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the comment has been edited' do
          it 'calls resolver and return comment' do
            expect(Resolvers::Comments::Edit).to receive(:call).and_call_original
            expect(result['data']['editComment']['comment']).to be_present
          end
        end
      end
    end

    describe '#destroy' do
      let(:mutation) {
         <<-GRAPHQL
          mutation {
            destroyComment(input: { id: #{target_comment.id} }) {
              success
            }
          }
        GRAPHQL
      }

      describe '#execute' do
        context 'when the comment has been destroyed' do
          it 'calls resolver and return comment' do
            expect(Resolvers::Comments::Destroy).to receive(:call).and_call_original
            expect(result['data']['destroyComment']['success']).to be_truthy
          end
        end
      end
    end
  end
end
