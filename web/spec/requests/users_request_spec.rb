require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:users) { FactoryBot.create_list(:user, 10) }
  let(:json) { JSON.parse(response.body) }

  context 'GET: /api/users' do
    before do
      users
      get '/api/users'
      @json = JSON.parse(response.body)
    end

    it 'status is 200' do
      expect(response.status).to eq(200)
    end

    it 'can get 10 users' do
      expect(@json['data'].length).to eq(10)
    end
  end

  context 'GET: api/uers/:id' do
    before do
      @user = user
      get "/api/users/#{@user.id}"
      @json = JSON.parse(response.body)
    end

    it 'status is 200' do
      expect(response.status).to eq(200)
    end

    it 'can get the user' do
      expect(@json['data']['id']).to eq(@user.id)
    end
  end

  context 'POST: /api/users' do
    before do
      @params = {
        user: {
          name: '山田太郎',
          email: 'taro@example.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }

      post '/api/users', params: @params
      @json = JSON.parse(response.body)
    end

    it 'status is 200' do
      expect(response.status).to eq(200)
    end

    it 'can create the user' do
      expect(@json['data']['email']).to eq(@params[:user][:email])
    end
  end

  context 'PATCH: /api/users/:id' do
    before do
      @user = user
      @params = {
        user: {
          name: '井上園子',
          email: 'sonoko@example.com',
        }
      }
      patch "/api/users/#{@user.id}", params: @params
    end

    it 'status is 200' do
      expect(response.status).to eq(200)
    end

    it 'can update the user' do
      expect(json['data']['name']).to eq(@params[:user][:name])
      expect(json['data']['name']).not_to eq(@user.name)
    end
  end
end
