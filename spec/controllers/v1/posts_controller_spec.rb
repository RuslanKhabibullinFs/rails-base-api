require 'spec_helper'

describe V1::PostsController do
  let(:post) { build :post }
  let(:posts) { [post] }

  before do
    allow(posts).to receive_messages(find: post, total_count: 1, limit_value: 1, current_page: 1)
    allow(Post).to receive_message_chain(:page, :per, :with_comments_and_users).and_return(posts)
  end

  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response.code).to eq('200')
    end

    it 'assigns posts' do
      expect(controller.posts).to match_array(posts)
    end
  end

  describe 'GET #show' do
    before do
      get :show, id: 1, format: :json
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response.code).to eq('200')
    end

    it 'assigns post' do
      expect(controller.post).to eq(post)
    end
  end
end