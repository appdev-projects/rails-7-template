class ProgramsController < ApplicationController
  before_action :set_program, only: %i[ show edit update destroy ]

  # GET /programs or /programs.json
  def index
    @programs = Program.all
  end
  def show
    @program = Program.find(params[:id])

  end

  # GET /programs/1 or /programs/1.json
  # def add_students
  #   @program = Program.find(params[:id])
  #   students_to_add = Student.where(id: params[:student_ids])

  #   @program.students << students_to_add

  #   redirect_to @program, notice: "Students added successfully to the program."
  # end

  # GET /programs/new
  def new
    @program = Program.new
    @program.students.build
  end

  # GET /programs/1/edit
  def edit
    @program = Program.find(params[:id])
    @program.students.build if @program.students.empty?
  end

  # POST /programs or /programs.json
  def create
    @program = Program.new(program_params)
    # students_to_add = Student.where(id: params[:student_ids])

    # @program.students << students_to_add

    respond_to do |format|
      if @program.save
        format.html { redirect_to program_url(@program), notice: "Program was successfully created." }
        format.json { render :show, status: :created, location: @program }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1 or /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to program_url(@program), notice: "Program was successfully updated." }
        format.json { render :show, status: :ok, location: @program }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1 or /programs/1.json
  def destroy
    @program.destroy

    respond_to do |format|
      format.html { redirect_to programs_url, notice: "Program was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def program_params
      params.require(:program).permit(:user_id, :school_id, :curriculum_id, :season, :days, :times, :student_id, :program_id, :id, student_ids: [])
    end    
end
