require 'rails_helper'

RSpec.describe HelloController do
  describe 'GET #index' do
    before(:each) do
      get :index
    end

    it 'responds with HTTP 200 code' do
      expect(response).to be_success
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'passes score to the view' do
      expect(assigns(:score).score).to equal(1234)
    end
  end
end
