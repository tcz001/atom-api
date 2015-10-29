class GameVersionsController < ApplicationController
  before_action :set_game_version, only: [:show, :edit, :update, :destroy]

  # GET /game_versions
  # GET /game_versions.json
  def index
    @game_versions = GameVersion.all
  end

  # GET /game_versions/1
  # GET /game_versions/1.json
  def show
  end

  # GET /game_versions/new
  def new
    @game_version = GameVersion.new
  end

  # GET /game_versions/1/edit
  def edit
  end

  # POST /game_versions
  # POST /game_versions.json
  def create
    @game_version = GameVersion.new(game_version_params)

    respond_to do |format|
      if @game_version.save
        format.html { redirect_to @game_version, notice: 'Game version was successfully created.' }
        format.json { render :show, status: :created, location: @game_version }
      else
        format.html { render :new }
        format.json { render json: @game_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_versions/1
  # PATCH/PUT /game_versions/1.json
  def update
    respond_to do |format|
      if @game_version.update(game_version_params)
        format.html { redirect_to @game_version, notice: 'Game version was successfully updated.' }
        format.json { render :show, status: :ok, location: @game_version }
      else
        format.html { render :edit }
        format.json { render json: @game_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_versions/1
  # DELETE /game_versions/1.json
  def destroy
    @game_version.destroy
    respond_to do |format|
      format.html { redirect_to game_versions_url, notice: 'Game version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_version
      @game_version = GameVersion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_version_params
      params.require(:game_version).permit(:game_id, :version, :language)
    end
end
