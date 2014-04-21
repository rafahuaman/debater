class ChambersController < ApplicationController
  before_action :set_chamber, only: [:show, :edit, :update, :destroy]

  # GET /chambers
  # GET /chambers.json
  def index
    @chambers = Chamber.all
  end

  # GET /chambers/1
  # GET /chambers/1.json
  def show
    @debates = @chamber.debates
  end

  # GET /chambers/new
  def new
    @chamber = Chamber.new
  end

  # GET /chambers/1/edit
  def edit
  end

  # POST /chambers
  # POST /chambers.json
  def create
    @chamber = Chamber.new(chamber_params)

    respond_to do |format|
      if @chamber.save
        format.html { redirect_to @chamber, notice: 'Chamber was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chamber }
      else
        format.html { render action: 'new' }
        format.json { render json: @chamber.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chambers/1
  # PATCH/PUT /chambers/1.json
  def update
    respond_to do |format|
      if @chamber.update(chamber_params)
        format.html { redirect_to @chamber, notice: 'Chamber was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chamber.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chambers/1
  # DELETE /chambers/1.json
  def destroy
    @chamber.destroy
    respond_to do |format|
      format.html { redirect_to chambers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chamber
      @chamber = Chamber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chamber_params
      params.require(:chamber).permit(:name, :description)
    end
end
