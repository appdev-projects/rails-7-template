class TestersController < ApplicationController
  skip_before_action :authenticate_employee!, only: [:welcome]
  before_action :set_tester, only: %i[ show edit update destroy trash ]
  before_action(except: [:welcome]) { authorize(@tester || Tester) }

  # GET /testers or /testers.json

  def welcome
    if current_employee == nil
      render "welcome"
    else
      redirect_to testers_path
    end
  end

  def index
    @testers = Tester.current_shop(current_employee).not_trashed.not_onstage.order(created_at: "DESC")
    @q = @testers.ransack(params[:q])
    @searchable_testers = @q.result.includes(:product).page(params[:page]).per(6)

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
    @products = @q.result(distinct: true).page(params[:page]).per(6)

    respond_to do |format|
      format.html
      format.js
    end

    @breadcrumbs = [
      { content: "Home", href: root_path },
      { content: "New Tester", href: new_tester_path },
    ]
  end

  # GET /testers/1/edit
  def edit
    @breadcrumbs = [
      { content: "Home", href: root_path },
      { content: "Edit Tester", href: edit_tester_path },
      { content: @tester.to_s },
    ]
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

    @breadcrumbs = [
      { content: "New Tester", href: new_tester_path },
      { content: "Tester", href: tester_path(@tester) },
    ]
  end

  # DELETE /testers/1 or /testers/1.json
  def destroy
    @tester.destroy

    respond_to do |format|
      format.html { redirect_to manage_path, notice: "Tester was successfully removed from inventory." }
      format.json { head :no_content }
    end
  end

  def trash
    @tester.update(trashed_at: Time.current)

    respond_to do |format|
      format.html { redirect_to trashed_path, notice: "Tester was successfully trashed." }
      format.json { head :no_content }
    end
  end

  def trashed
    # Can this query be done in the model?
    @testers = Tester.current_shop(current_employee).trashed.order(created_at: "DESC").page(params[:page]).per(6)
  end

  # /makeup
  def makeup
    @department = "Makeup"
    @testers = Tester.by_department(current_employee, "Makeup").page(params[:page]).per(6)

    render "department_testers"
  end

  # /skincare
  def skincare
    @department = "Skincare"
    @testers = Tester.by_department(current_employee, "Skincare").page(params[:page]).per(6)

    render "department_testers"
  end

  # /hair
  def hair
    @department = "Hair"
    @testers = Tester.by_department(current_employee, "Hair").page(params[:page]).per(6)

    render "department_testers"
  end

  # /fragrance
  def fragrance
    @department = "Fragrance"
    @testers = Tester.by_department(current_employee, "Fragrance").page(params[:page]).per(6)

    render "department_testers"
  end

  # /manage_testers
  def manage
    @onstage_testers = Tester.current_shop(current_employee).onstage.not_trashed.order(created_at: "DESC").page(params[:onstage_page]).per(6)

    @backstage_testers = Tester.current_shop(current_employee).not_onstage.not_trashed.order(created_at: "DESC").page(params[:backstage_page]).per(6)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tester
    @tester = Tester.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tester_params
    params.require(:tester).permit(:product_id, :shop_id, :condition, :location, :trashed_at)
  end
end
