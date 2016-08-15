class APIKeysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_api_key, only: [:show, :destroy]

  # GET /api_keys
  # GET /api_keys.json
  def index
    @api_keys = policy_scope(APIKey)
  end

  # GET /api_keys/1
  # GET /api_keys/1.json
  def show
    authorize @api_key
  end

  # GET /api_keys/new
  def new
    @api_key = APIKey.new
  end

  # POST /api_keys
  # POST /api_keys.json
  def create
    @api_key = APIKey.new(api_key_params)
    @api_key.user = current_user

    respond_to do |format|
      if @api_key.save
        format.html { redirect_to @api_key, notice: 'API key was successfully created.' }
        format.json { render :show, status: :created, location: @api_key }
      else
        format.html { render :new }
        format.json { render json: @api_key.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_keys/1
  # DELETE /api_keys/1.json
  def destroy
    authorize @api_key
    @api_key.destroy
    respond_to do |format|
      format.html { redirect_to api_keys_url, notice: 'API key was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_key
      @api_key = APIKey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_key_params
      params.require(:api_key).permit(:read_key, :write_key)
    end
end
