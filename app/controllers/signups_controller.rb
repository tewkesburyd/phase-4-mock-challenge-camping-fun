class SignupsController < ApplicationController
  before_action :set_signup, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid

  # POST /signups
  def create
    signup = Signup.create!(signup_params)
    activity = Activity.find(signup_params[:activity_id])
    render json: activity, status: :created
  end

  private
  
  def render_invalid(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end
  # Use call
    # Use callbacks to share common setup or constraints between actions.
    def set_signup
      @signup = Signup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def signup_params
      params.permit(:camper_id, :activity_id, :time)
    end
end
