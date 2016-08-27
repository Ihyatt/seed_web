class ReactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reaction, only: [:show, :edit, :update, :destroy]

  # GET /reactions
  def index
    raise Pundit::NotAuthorizedError if !current_user.is_admin
    @positive_reactions = Reaction.positive.by_position
    @negative_reactions = Reaction.negative.by_position
  end

  # GET /reactions/1
  def show
  end

  # GET /reactions/new
  def new
    authorize Reaction
    @reaction = Reaction.new
  end

  # GET /reactions/1/edit
  def edit
  end

  # POST /reactions
  def create
    @reaction = Reaction.new(reaction_params)
    authorize @reaction

    if @reaction.save
      redirect_to @reaction, notice: 'Reaction was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /reactions/1
  def update
    if @reaction.update(reaction_params)
      redirect_to @reaction, notice: 'Reaction was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /reactions/1
  def destroy
    @reaction.destroy
    redirect_to reactions_url, notice: 'Reaction was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reaction
      @reaction = Reaction.find(params[:id])
      authorize @reaction
    end

    # Only allow a trusted parameter "white list" through.
    def reaction_params
      params.require(:reaction).permit(:name, :positive, :position)
    end
end
