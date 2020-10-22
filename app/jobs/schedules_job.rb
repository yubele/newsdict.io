class SchedulesJob < ApplicationJob
  def perform
    schedules =  Configs::Schedule.current
    if schedules.count
      schedules.each do |schedule|
        schedule.posts.each do |post|
          post.post
        end
      end
    end
  end
end