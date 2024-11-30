class TestersController < ApplicationController
  before_action :set_tester, only: %i[ show edit update destroy trash]
  before_action {authorize(@tester || Tester)}

  # GET /testers or /testers.json
  def index
    @testers = Tester.where(shop_id: current_employee.shop_id, trashed_at: nil).order(created_at: 'DESC')
    @q = @testers.ransack(params[:q])
    @searchable_testers = @q.result.includes(:product)

    respond_to do |format|
      format.html
      format.js 
    end
    
  end
  # GET /testers/1 or /testers/1.json
  def show
  end

  # GET /testers/new
  def new
    @tester = Tester.new()
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct:true)

    respond_to do |format|
      format.html
      format.js 
    end
  end
  # GET /testers/1/edit
  def edit
  end

  # POST /testers or /testers.json
  def create
    @tester = Tester.new(tester_params)

    respond_to do |format|
      if @tester.save
        format.html { redirect_to tester_url(@tester), notice: "Tester was successfully created." }
        format.json { render :show, status: :created, location: @tester }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tester.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testers/1 or /testers/1.json
  def update
    respond_to do |format|
      if @tester.update(tester_params)
        format.html { redirect_to tester_url(@tester), notice: "Tester was successfully updated." }
        format.json { render :show, status: :ok, location: @tester }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tester.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testers/1 or /testers/1.json
  def destroy
    @tester.destroy

    respond_to do |format|
      format.html { redirect_to testers_url, notice: "Tester was successfully trashed." }
      format.json { head :no_content }
    end
  end

  def trash
    @tester.update(trashed_at: Time.current)

    respond_to do |format|
      format.html { redirect_to testers_url, notice: "Tester was successfully trashed." }
      format.json { head :no_content }
    end
  end

  def trashed
    @testers = Tester.where(shop_id: current_employee.shop_id).where.not(trashed_at: nil).order(created_at: 'DESC')
    render "trashed"
  end

  # /makeup
  def makeup
    @department=Department.find_by(name: "Makeup")
    @testers = Tester.where(
      shop_id: current_employee.shop_id,
      product_id: Product.where(department_id: @department.id).pluck(:id),
      trashed_at: nil
    ).order(created_at: 'DESC')
    render "department_testers"
  end

  # /skincare
  def skincare
    @department=Department.find_by(name: "Skincare")
    @testers = Tester.where(
      shop_id: current_employee.shop_id,
      product_id: Product.where(department_id: @department.id).pluck(:id),
      trashed_at: nil
    ).order(created_at: 'DESC')
    render "department_testers"
  end

  # /hair
  def hair
    @department=Department.find_by(name: "Hair")
    @testers = Tester.where(
      shop_id: current_employee.shop_id,
      product_id: Product.where(department_id: @department.id).pluck(:id),
      trashed_at: nil
    ).order(created_at: 'DESC')
    render "department_testers"
  end
  
  # /fragrance
  def fragrance
    @department=Department.find_by(name: "Fragrance")
    @testers = Tester.where(
      shop_id: current_employee.shop_id,
      product_id: Product.where(department_id: @department.id).pluck(:id),
      trashed_at: nil
    ).order(created_at: 'DESC')
    render "department_testers"
  end

  # /manage_testers
  def manage
    @testers = Tester.where(shop_id: current_employee.shop_id).where(trashed_at: nil).order(created_at: 'DESC')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tester
      @tester = Tester.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tester_params
      params.require(:tester).permit(:product_id, :shop_id, :condition, :trashed_at)
    end
end
