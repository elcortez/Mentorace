require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:course) { create(:course) }
  before { allow(controller).to receive(:authenticate_user!) }

  describe 'index, show' do
    it 'index' do
      response = get :index
      expect(response.code).to eql('200')
    end

    it 'show' do
      response = get :show, params: { id: course.id }
      expect(response.code).to eql('200')
    end
  end
end
