class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :edit, :update, :destroy, :discussion_comment, :comment, :render_comments]

  # GET /discussions
  # GET /discussions.json
  def index
    @discussions = Discussion.all
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
  end

  # GET /discussions/new
  def new
    @discussion = Discussion.new
  end

  # GET /discussions/1/edit
  def edit
  end

  # POST /discussions
  # POST /discussions.json
  def create
    @discussion = Discussion.new(discussion_params)

    respond_to do |format|
      if @discussion.save
        format.html { redirect_to @discussion, notice: 'Discussion was successfully created.' }
        format.json { render :show, status: :created, location: @discussion }
      else
        format.html { render :new }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discussions/1
  # PATCH/PUT /discussions/1.json
  def update
    respond_to do |format|
      if @discussion.update(discussion_params)
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { render :show, status: :ok, location: @discussion }
      else
        format.html { render :edit }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    @discussion.destroy
    respond_to do |format|
      format.html { redirect_to discussions_url, notice: 'Discussion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def comment
    comments_params = discussion_comments_params[:comments]

    @discussion.comments.create(content: comments_params[:content], user_id: current_user.id)

    owner = @discussion.user
    lecture_recording = @discussion.lecture_recording
    video = @discussion.video

    if lecture_recording.present?
      if owner != current_user
        owner.notifications.create(content: "#{current_user.name} commented on your discussion #{@discussion.title}",
                                   path: unit_of_study_semester_lecture_recording_path(lecture_recording.semester.unit_of_study, lecture_recording.semester, lecture_recording))
      else
        @discussion.comments.pluck(:user_id).each do |uid|
          u = User.find_by_id(uid)
          p '***'
          p u
          p '***'
          if u.present? and (u != current_user or u != owner)
            u.notifications.create(content: "#{current_user.name} has commented on #{@discussion.title}",
                                   path: unit_of_study_semester_lecture_recording_path(lecture_recording.semester.unit_of_study, lecture_recording.semester, lecture_recording))
          end
        end
      end
    else
      if owner != current_user
        owner.notifications.create(content: "#{current_user.name} commented on your discussion #{@discussion.title}",
                                   path: community_video_path(video.community_id, video))
      else
        @discussion.comments.pluck(:user).each do |u|
          if u != current_user or u != owner
            u.notifications.create(content: "#{current_user.name} has commented on #{@discussion.title}",
                                   path: community_video_path(video.community_id, video))
          end
        end
      end
    end


    respond_to do |format|
      format.html { redirect_to root_path, notice: 'plz work' }
      format.json { head :no_content }
    end
  end

  def render_comments
    @comments = @discussion.comments.order(created_at: :asc)
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discussion
      @discussion = Discussion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def discussion_params
      params.require(:discussion).permit(:title, :content, :lecture_recording_id, :video_id, :user_id, :start_time, :end_time)
    end

    def discussion_comments_params
      params.require(:discussion)
    end
end
