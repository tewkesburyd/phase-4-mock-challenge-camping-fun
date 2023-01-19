class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  # GET /activities
  def index
    @activities = Activity.all

    render json: @activities
  end

  # DELETE /activities/1
  def destroy
    @activity.destroy
    head :no_content
  end

  private

    def render_not_found
      render json: {error: "Activity not found"}, status: :not_found
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.require(:activity).permit(:name, :difficulty)
    end
end
