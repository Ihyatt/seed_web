class RacesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  # GET /races
  def index
    raise Pundit::NotAuthorizedError if !current_user.is_admin
    @races = Race.all
  end

  # GET /races/1
  def show
    authorize @race
  end

  # GET /races/new
  def new
    authorize Race
    @race = Race.new
  end

  # GET /races/1/edit
  def edit
    authorize @race
  end

  # POST /races
  def create
    @race = Race.new(race_params)
    authorize @race

    if @race.save
      redirect_to @race, notice: 'Race was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /races/1
  def update
    authorize @race
    if @race.update(race_params)
      redirect_to @race, notice: 'Race was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /races/1
  def destroy
    authorize @race
    @race.destroy
    redirect_to races_url, notice: 'Race was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def race_params
      params.require(:race).permit(:name, :position)
    end
end
