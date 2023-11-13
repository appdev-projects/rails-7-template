class SnapshotsController < ApplicationController
  before_action :set_snapshot, only: %i[ show edit update destroy ]

  # GET /snapshots or /snapshots.json
  def index
    @snapshots = Snapshot.all
  end

  # GET /snapshots/1 or /snapshots/1.json
  def show
  end

  # GET /snapshots/new
  def new
    @snapshot = Snapshot.new
  end

  # GET /snapshots/1/edit
  def edit
  end

  # POST /snapshots or /snapshots.json
  def create
    @snapshot = Snapshot.new(snapshot_params)

    respond_to do |format|
      if @snapshot.save
        format.html { redirect_to snapshot_url(@snapshot), notice: "Snapshot was successfully created." }
        format.json { render :show, status: :created, location: @snapshot }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snapshots/1 or /snapshots/1.json
  def update
    respond_to do |format|
      if @snapshot.update(snapshot_params)
        format.html { redirect_to snapshot_url(@snapshot), notice: "Snapshot was successfully updated." }
        format.json { render :show, status: :ok, location: @snapshot }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snapshots/1 or /snapshots/1.json
  def destroy
    @snapshot.destroy

    respond_to do |format|
      format.html { redirect_to snapshots_url, notice: "Snapshot was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snapshot
      @snapshot = Snapshot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def snapshot_params
      params.require(:snapshot).permit(:price, :listing_id)
    end
end
