require 'rails_helper'

describe CommentsController, type: :controller do
  let(:user) do
    FactoryBot.create(:user)
  end

  let!(:posts) do
    10.times.map do
      FactoryBot.create(:post, user: user)
    end
  end

  let!(:comments) do
    5.times.map do
      FactoryBot.create(
        :comment,
        user: user,
        post: posts.last
      )
    end
  end

  before do
    sign_in user
  end

  describe '#create' do
    context 'with valid params' do
      before do
        controller.instance_variable_set(:@post, posts.last)
      end

      it 'creates the comment' do
        post :create, params: {
          post_id: posts.last.id,
          comments: {
            body: 'message'
          }
        }

        expect(response).to redirect_to(post_url(Post.last.id))
        expect(flash[:notice]).to eq('Comment created')
      end
    end

    context 'with invalid params' do
      before do
        controller.instance_variable_set(:@post, posts.last)
      end

      it 'does not create the comment' do
        post :create, params: {
          post_id: posts.last.id,
          comments: {
            body: nil
          }
        }

        expect(response).to redirect_to(post_url(Post.last.id))
        expect(flash[:alert]).to eq('Comment was not created')
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      before do
        controller.instance_variable_set(:@post, posts.last)
      end

      it 'updates the comment' do
        patch :update, params: {
          post_id: posts.last.id,
          id: comments.last.id,
          comments: {
            body: 'message'
          }
        }

        expect(response).to redirect_to(post_url(Post.last.id))
        expect(flash[:notice]).to eq('Comment updated')
      end
    end

    context 'with invalid params' do
      before do
        controller.instance_variable_set(:@post, posts.last)
      end

      it 'updates the comment' do
        patch :update, params: {
          post_id: posts.last.id,
          id: comments.last.id,
          comments: {
            body: nil
          }
        }

        expect(response).to redirect_to(post_url(Post.last.id))
        expect(flash[:alert]).to eq('Comment was not updated')
      end
    end
  end

  describe '#destroy' do
    context 'valid comments' do
      before do
        controller.instance_variable_set(:@post, posts.last)
      end

      it 'deletes the record' do
        delete :destroy, params: {
          post_id: posts.last.id,
          id: comments.last.id,
          comments: {
            body: 'body comment'
          }
        }

        expect(response).to redirect_to(post_url(posts.last.id))
        expect(response.status).to eq(302)
      end
    end
  end
end
