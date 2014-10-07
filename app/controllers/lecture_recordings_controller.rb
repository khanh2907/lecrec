class LectureRecordingsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:create]
  before_action :set_lecture_recording, only: [:show, :edit, :update, :destroy, :create_discussion, :get_discussions, :render_discussions]
  before_action :set_uos, except: [:create_discussion, :get_discussions, :render_discussions]
  before_action :set_semester, except: [:create_discussion, :get_discussions, :render_discussions]

  # GET /lecture_recordings
  # GET /lecture_recordings.json
  def index
    @lecture_recordings = LectureRecording.all
  end

  # GET /lecture_recordings/1
  # GET /lecture_recordings/1.json
  def show
    respond_to do |format|
      format.html
      format.json { render json: @lecture_recording }
    end
  end

  # GET /lecture_recordings/new
  def new
    if !current_user.is_admin? and !current_user.unit_of_studies.include? @uos
        begin
          redirect_to :back, :alert => "You are not authorized to access this page."
        rescue
          redirect_to root_url, :alert => "You are not authorized to access this page."
        end

    end
    @lecture_recording = LectureRecording.new()
  end

  # GET /lecture_recordings/1/edit
  def edit
  end

  # POST /lecture_recordings
  # POST /lecture_recordings.json
  def create
    @lecture_recording = current_user.lecture_recordings.new(lecture_recording_params)
    @lecture_recording.semester = @semester
    respond_to do |format|
      if @lecture_recording.save!
        valid_formats = ['.webm', 'mp4']
        unless valid_formats.include? File.extname(@lecture_recording.raw_video.current_path)
          Resque.enqueue(VideoConverter, @lecture_recording.id)
        end
        format.html { redirect_to unit_of_study_semester_lecture_recording_path(@uos, @semester, @lecture_recording), notice: 'Lecture recording was successfully created.' }
        format.json { render :show, status: :created, location: unit_of_study_semester_lecture_recording_path(@uos, @semester, @lecture_recording) }
      else
        format.html { render :new }
        format.json { render json: @lecture_recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lecture_recordings/1
  # PATCH/PUT /lecture_recordings/1.json
  def update
    respond_to do |format|
      if @lecture_recording.update(lecture_recording_params)
        format.html { redirect_to unit_of_study_semester_lecture_recording_path(@uos, @semester, @lecture_recording), notice: 'Lecture recording was successfully updated.' }
        format.json { render :show, status: :ok, location: unit_of_study_semester_lecture_recording_path(@uos, @semester, @lecture_recording) }
      else
        format.html { render :edit }
        format.json { render json: @lecture_recording.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lecture_recordings/1
  # DELETE /lecture_recordings/1.json
  def destroy
    @lecture_recording.destroy
    respond_to do |format|
      format.html { redirect_to unit_of_study_semester_path(@uos, @semester), notice: 'Lecture recording was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_discussion
      discussion_params = lecture_discussion_params[:discussions]

      @lecture_recording.discussions.create(title: discussion_params[:title],
                                            content: discussion_params[:content],
                                            start_time: discussion_params[:start_time],
                                            end_time: discussion_params[:end_time],
                                            user_id: params[:user_id])

      respond_to do |format|
        format.html { redirect_to unit_of_study_semester_lecture_recording_path(@lecture_recording.semester.unit_of_study, @lecture_recording.semester, @lecture_recording), notice: 'plz work' }
        format.json { head :no_content }
      end
  end

  def get_discussions
    render json: @lecture_recording.discussions.order(created_at: :asc)
  end

  def render_discussions
    @discussions = @lecture_recording.discussions.order(created_at: :desc)
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture_recording
      @lecture_recording = LectureRecording.find(params[:id])
    end

    def set_semester
      @semester = Semester.find(params[:semester_id])
    end

    def set_uos
      @uos = UnitOfStudy.find(params[:unit_of_study_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_recording_params
      params.require(:lecture_recording).permit(:name, :raw_video)
    end

    def lecture_discussion_params
      params.require(:lecture_recording)
    end
end
