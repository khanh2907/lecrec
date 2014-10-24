class VisitorsController < ApplicationController
  def index
    if user_signed_in?

      @lecrecs = []

      current_user.semesters.each do |s|
        @lecrecs << s.lecture_recordings.where(ready: true).last unless s.lecture_recordings.where(ready: true).last.nil?
      end
    else
      redirect_to new_user_session_path
    end

  end

  def lectures

  end
end
