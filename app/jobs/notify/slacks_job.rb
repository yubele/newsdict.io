class Notify::SlacksJob < ApplicationJob
  queue_as :notify
  def perform
    Configs::Tokens::Slack.all.each do |slack|
      schedule = slack.configs_schedule
      if schedule.is_active && schedule.runnable_time?
        gt = schedule.last_schedule_at.to_s
        lte = Time.now.to_s
        contents = Contents::Web.contents(category_id: slack.notify_target_category_id).sortable.term(gt, lte)
        if contents.exists?
          slack.send_message(contents)
        end
      end
    end
  end
end