class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy, :create_discussion, :get_discussions, :render_discussions]
  before_action :set_community, except: [:create_discussion, :get_discussions, :render_discussions]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    @video.community_id = @community.id
    @video.user_id = current_user.id

    respond_to do |format|
      if @video.save
        format.html { redirect_to community_video_path(@community, @video), notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    community = @video.community
    @video.destroy
    respond_to do |format|
      format.html { redirect_to community_path(community), notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_discussion
    discussion_params = video_discussion_params[:discussions]

    @video.discussions.create(title: discussion_params[:title],
                                          content: discussion_params[:content],
                                          user_id: params[:user_id])

    respond_to do |format|
      owner = @video.user
      if owner != current_user
        owner.notifications.create(content: "#{current_user.name} has started a discussion on #{@video.community.title} video #{@video.title}",
                                   path: community_video_path(@video.community_id, @video))
      end
      format.html { redirect_to community_video_path(@video.community_id, @video), notice: 'plz work' }
      format.json { head :no_content }
    end
  end

  def get_discussions
    render json: @video.discussions.order(created_at: :asc)
  end

  def render_discussions
    @discussions = @video.discussions.order(created_at: :desc)
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :content_url)
    end

    def set_community
      @community = Community.find(params[:community_id])
    end

    def video_discussion_params
      params.require(:video)
    end
end
