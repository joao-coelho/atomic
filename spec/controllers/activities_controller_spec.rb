require 'rails_helper'

RSpec.describe ActivityController, type: :controller do
  describe "GET index" do
    it "assigns all available activities" do
      create_list(:activity, 10)

      get :index

      expect(assigns(:activities)).to eq(Activity.all)
    end
  end

  describe "GET show" do
    it "assigns correct activity" do
      activity = create(:activity)

      get :show, params: { id: activity.id }

      expect(assigns(:activity)).to eq(activity)
    end
  end

  describe "GET new" do
    it "assigns a new activity" do
      get :new

      expect(assigns(:activity)).to be
    end
  end

  describe "POST create" do
    it "creates a new activity" do
      activity_params = attributes_for(:activity)

      expect do
        post :create, params: { activity_params }
      end.to change { Activity.count }.by(1)
    end

    it "redirects to new activty" do
      activity_params = attributes_for(:activity)

      post :create, params: { activity_params }

      expect(response).to redirect_to(Activity.last)
    end

    it "doesn't create when provided invalid params" do
      activity_params = attributes_for(:activity, name: nil)

      expect do
        post :create, params: { activity_params }
      end.not_to change { Activity.count }
    end
  end

  describe "GET edit" do
    it "assigns the correct activity" do
      activity = create(:activity)

      get :edit, params: { id: activity.id }

      expect(assigns(:activity)).to eq(activity)
    end
  end

  describe "POST update" do
    it "correcly updates activity" do
      activity = create(:activity)
      activity_params = attributes_for(:activity)

      post :update, params: { id: activity.id, activity: activity_params }

      activity.reload

      expect(activity.name).to eq(activity_params[:name])
      expect(activity.location).to eq(activity_params[:location])
      expect(activity.description).to eq(activity_params[:description])
      expect(activity.total_rating).to eq(activity_params[:total_rating])
      expect(activity.member_cost).to eq(activity_params[:member_cost])
      expect(activity.guest_cost).to eq(activity_params[:guest_cost])
      expect(activity.start_date).to eq(activity_params[:start_date])
      expect(activity.end_date).to eq(activity_params[:end_date])
      expect(activity.coffee_break).to eq(activity_params[:coffee_break])
      expect(activity.department_id).to eq(activity_params[:department_id])
    end

    it "redirects to updated activity" do
      activity = create(:activity)
      activity_params = attributes_for(:activity)

      post :update, params: { id: activity.id, activity: activity_params }

      expect(response).to redirect_to(activity)
  end

    it "doesn't update when provided with invalid params" do
      activity = create(:activity)
      activity_params = { name: nil }

      post :update, params: { id: activity.id, activity: activity_params }

      reloaded_activity = Activity.find(activity.id)
      expect(reloaded_activity.name).to eq(activity.name)
    end
  end

  describe "DELETE destroy" do
    it "deletes the correct activity" do
      activity = create(:activity)

      expect do
        delete :destroy, params: { id: activity.id }
      end.to change { Activity.count }.by(1)
    end

    it "redirects to index" do
      activity = create(:activity)

      delete :destroy, params: { id: activity.id }

      expect(response).to redirect_to(activities_url)
    end

    it "doesn't delete when provided with invalid id" do
      activity = create_list(:activity, 5)

      expect do
        delete :destroy, params: { id: -1 }
      end.not_to change { Activity.count }
    end
  end
end
