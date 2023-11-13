class RetailersController < ApplicationController
  before_action :set_retailer, only: %i[ show edit update destroy ]

  # GET /retailers or /retailers.json
  def index
    @retailers = Retailer.all
  end

  # GET /retailers/1 or /retailers/1.json
  def show
  end

  # GET /retailers/new
  def new
    @retailer = Retailer.new
  end

  # GET /retailers/1/edit
  def edit
  end

  # POST /retailers or /retailers.json
  def create
    @retailer = Retailer.new(retailer_params)

    respond_to do |format|
      if @retailer.save
        format.html { redirect_to retailer_url(@retailer), notice: "Retailer was successfully created." }
        format.json { render :show, status: :created, location: @retailer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @retailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /retailers/1 or /retailers/1.json
  def update
    respond_to do |format|
      if @retailer.update(retailer_params)
        format.html { redirect_to retailer_url(@retailer), notice: "Retailer was successfully updated." }
        format.json { render :show, status: :ok, location: @retailer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @retailer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /retailers/1 or /retailers/1.json
  def destroy
    @retailer.destroy

    respond_to do |format|
      format.html { redirect_to retailers_url, notice: "Retailer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_retailer
      @retailer = Retailer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def retailer_params
      params.require(:retailer).permit(:name, :listing_count)
    end
end
