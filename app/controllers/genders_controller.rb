class GendersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_gender, only: [:show, :edit, :update, :destroy]

  # GET /genders
  def index
    raise Pundit::NotAuthorizedError if !current_user.is_admin
    @genders = Gender.by_position
  end

  # GET /genders/1
  def show
    authorize @gender
  end

  # GET /genders/new
  def new
    authorize Gender
    @gender = Gender.new
  end

  # GET /genders/1/edit
  def edit
    authorize @gender
  end

  # POST /genders
  def create
    @gender = Gender.new(gender_params)
    authorize @gender

    if @gender.save
      redirect_to @gender, notice: 'Gender was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /genders/1
  def update
    authorize @gender
    if @gender.update(gender_params)
      redirect_to @gender, notice: 'Gender was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /genders/1
  def destroy
    authorize @gender
    @gender.destroy
    redirect_to genders_url, notice: 'Gender was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gender
      @gender = Gender.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def gender_params
      params.require(:gender).permit(:name, :position)
    end
end
