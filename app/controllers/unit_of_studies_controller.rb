class UnitOfStudiesController < ApplicationController
  before_action :set_unit_of_study, only: [:show, :edit, :update, :destroy]

  # GET /unit_of_studies
  # GET /unit_of_studies.json
  def index
    @unit_of_studies = UnitOfStudy.all
  end

  # GET /unit_of_studies/1
  # GET /unit_of_studies/1.json
  def show
  end

  # GET /unit_of_studies/new
  def new
    @unit_of_study = UnitOfStudy.new
  end

  # GET /unit_of_studies/1/edit
  def edit
  end

  # POST /unit_of_studies
  # POST /unit_of_studies.json
  def create
    @unit_of_study = UnitOfStudy.new(unit_of_study_params)

    respond_to do |format|
      if @unit_of_study.save
        format.html { redirect_to @unit_of_study, notice: 'Unit of study was successfully created.' }
        format.json { render :show, status: :created, location: @unit_of_study }
      else
        format.html { render :new }
        format.json { render json: @unit_of_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unit_of_studies/1
  # PATCH/PUT /unit_of_studies/1.json
  def update
    respond_to do |format|
      if @unit_of_study.update(unit_of_study_params)
        format.html { redirect_to @unit_of_study, notice: 'Unit of study was successfully updated.' }
        format.json { render :show, status: :ok, location: @unit_of_study }
      else
        format.html { render :edit }
        format.json { render json: @unit_of_study.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unit_of_studies/1
  # DELETE /unit_of_studies/1.json
  def destroy
    @unit_of_study.destroy
    respond_to do |format|
      format.html { redirect_to unit_of_studies_url, notice: 'Unit of study was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit_of_study
      @unit_of_study = UnitOfStudy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_of_study_params
      params.require(:unit_of_study).permit(:title, :alpha_code, :description)
    end
end
