class NotifiesJob < ApplicationJob
  def perform
    Configs::Schedule.all.each do |schedule|
      if schedule.runnable_time?
        gt = schedule.last_schedule_at.to_s
        lte = Time.now.to_s
        contents = Content.contents(category_id: schedule.category_id).sortable.term(gt, lte)
        if contents.exists?
          Configs::Hook.trigger(:schedule, contents)
        end
      end
    end
  end
end