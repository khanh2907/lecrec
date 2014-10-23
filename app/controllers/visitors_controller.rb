class VisitorsController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?

    @lecrecs = []

    current_user.semesters.each do |s|
      @lecrecs << s.lecture_recordings.where(ready: true).last unless s.lecture_recordings.last.nil?
    end

  end

  def lectures

  end
end
