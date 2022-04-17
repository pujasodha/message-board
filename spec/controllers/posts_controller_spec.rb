require 'rails_helper'

describe PostsController, type: :controller do
  let(:user) do
    FactoryBot.create(:user)
  end

  let!(:posts) do
    10.times.map do
      FactoryBot.create(:post, user: user)
    end
  end

  before do
    sign_in user
  end

  describe '#index' do
    context 'no posts present' do
      before do
        allow(controller).to receive(:all_posts).and_return(nil)
      end

      it 'returns nil' do
        expect(controller.index).to eq(nil)
      end
    end

    context 'posts present' do
      it 'returns all posts' do
        expect(controller.index.count).to eq(posts.count)
      end
    end
  end

  describe '#show' do
    context 'no comments present' do
      before do
        controller.instance_variable_set(:@post, posts.first)
      end

      it 'returns an empty array' do
        expect(controller.show).to eq([])
      end
    end

    context 'comments present' do
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
        controller.instance_variable_set(:@post, posts.last)
      end

      it 'returns the comments' do
        expect(controller.show.count).to eq(comments.count)
      end
    end
  end

  describe '#new' do
    context 'new post' do
      it 'creates a post' do
        expect(controller.new).to be_a_new(Post)
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates the post' do
        new_post = FactoryBot.create(:post, user: user)

        post :create, params: {
          id: new_post.id,
          post: {
            title: 'Title',
            message: 'Message'
          }
        }

        expect(response).to redirect_to(post_url(Post.last.id))
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Message successfully created')
      end
    end

    context 'with missing message' do
      it 'does not create the post' do
        post :create, params: {
          id: posts.last.id,
          post: {
            title: 'Title',
            message: nil
          }
        }

        expect(response.status).to eq(422)
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'updates the post' do
        patch :update, params: {
          id: posts.first.id,
          post: {
            title: 'Title',
            message: 'Message'
          }
        }

        expect(response).to redirect_to(post_url)
        expect(response.status).to eq(302)
        expect(flash[:notice]).to eq('Message successfully updated')
      end
    end

    context 'with missing title' do
      it 'does not update the post' do
        patch :update, params: {
          id: posts.first.id,
          post: {
            title: nil,
            message: 'Message'
          }
        }

        expect(response.status).to eq(422)
      end
    end

    context 'with missing message' do
      it 'does not update the post' do
        patch :update, params: {
          id: posts.first.id,
          post: {
            title: 'Title',
            message: nil
          }
        }

        expect(response.status).to eq(422)
      end
    end
  end

  describe '#destroy' do
    context 'valid posts' do
      it 'deletes the record' do
        delete :destroy, params: { id: posts.last.id }

        expect(response).to redirect_to(posts_url)
        expect(response.status).to eq(302)
      end
    end
  end
end
