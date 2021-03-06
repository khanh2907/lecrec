class SemestersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:create, :new]
  before_action :set_semester, only: [:show, :edit, :update, :destroy]
  before_action :set_uos
  # GET /semesters
  # GET /semesters.json
  def index
    @semesters = Semester.where(:unit_of_study_id => params[:unit_of_study_id])
  end

  # GET /semesters/1
  # GET /semesters/1.json
  def show
  end

  # GET /semesters/new
  def new
    @semester = Semester.new(unit_of_study_id: @uos.id)
  end

  # GET /semesters/1/edit
  def edit
  end

  # POST /semesters
  # POST /semesters.json
  def create
    @semester = Semester.new(semester_params)
    @semester.unit_of_study = @uos

    respond_to do |format|
      if @semester.save
        format.html { redirect_to unit_of_study_semester_path(@uos, @semester), notice: 'Semester was successfully created.' }
        format.json { render :show, status: :created, location: @semester }
      else
        format.html { render :new }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /semesters/1
  # PATCH/PUT /semesters/1.json
  def update
    respond_to do |format|
      if @semester.update(semester_params)
        format.html { redirect_to unit_of_study_semester_path(@uos, @semester), notice: 'Semester was successfully updated.' }
        format.json { render :show, status: :ok, location: unit_of_study_semester_path(@uos, @semester) }
      else
        format.html { render :edit }
        format.json { render json: @semester.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /semesters/1
  # DELETE /semesters/1.json
  def destroy
    @semester.destroy
    respond_to do |format|
      format.html { redirect_to unit_of_study_semesters_path(@uos), notice: 'Semester was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def enrol
    @users = User.all.except(current_user)
  end

  def enrol_student
    student = User.find_by_id(enrol_params[:student_id])
    unless student.nil?
      if @semester.users.include? student
        @semester.users.delete(student)
      else
        @semester.users << student
      end
    end
    respond_to do |format|
      format.html { redirect_to unit_of_study_semesters_path(@uos)}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_semester
      @semester = Semester.find(params[:id])
    end

    def set_uos
      @uos = UnitOfStudy.find_by_id(params[:unit_of_study_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def semester_params
      params.require(:semester).permit(:session, :year, :unit_of_study_id)
    end

    def enrol_params
      params.require(:enrol).permit(:student_id)
    end
end
