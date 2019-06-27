require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }

  describe "POST /signup" do
    context 'when request is valid' do
      before(:each) do
        post '/signup', params: attributes_for(:user)
      end

      it 'returns a 201 status code' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before(:each) do
        post '/signup', params: attributes_for(:user, email: nil)
      end

      it 'returns a 422 status code' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
