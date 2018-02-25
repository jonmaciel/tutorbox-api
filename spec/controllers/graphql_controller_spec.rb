require 'rails_helper'

describe GraphqlController, type: :controller do
  let!(:user) { users(:user_admin) }

  describe '#execute' do
    context 'user not signed in' do
      it 'does not show result' do
        post :execute

        expect(response).to have_http_status(401)
      end
    end

    context 'user signed in' do
      before { allow_any_instance_of(AuthorizeApiRequest).to receive(:user).and_return(user) }

      it 'does not show result' do
        post :execute

        expect(response).to have_http_status(200)
      end
    end
  end
end
