class CampersController < ApplicationController
  before_action :set_camper, only: [:show, :update, :destroy]

  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  # GET /campers
  def index
    render json: Camper.all
  end

  # GET /campers/1
  def show
    render json: @camper, serializer: CamperWithActivitiesSerializer
  end

  # POST /campers
  def create
    @camper = Camper.create!(camper_params)
    render json: @camper, status: :created
  end

  # PATCH/PUT /campers/1
  def update
    if @camper.update(camper_params)
      render json: @camper
    else
      render json: @camper.errors, status: :unprocessable_entity
    end
  end

  # DELETE /campers/1
  def destroy
    @camper.destroy
  end

  private

  def render_invalid(e)
    render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
  end

  def render_not_found
    render json: {error: "Camper not found"}, status: :not_found
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_camper
      @camper = Camper.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def camper_params
      params.permit(:name, :age)
    end
end
