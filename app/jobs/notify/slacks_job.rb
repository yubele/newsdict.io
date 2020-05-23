class Notify::SlacksJob < ApplicationJob
  queue_as :default
  def perform
    Configs::Tokens::Slack.all.each do |slack|
      schedule = slack.configs_schedule
      if schedule.is_active && schedule.runnable_time?
        gt = schedule.last_schedule_at.to_s
        lte = Time.now.to_s
        contents = Contents::Web.contents(category_id: chatwork.notify_target_category_id).sortable.term(gt, lte)
        if contents.exists?
          text = ""
          contents.each do |content|
            text << "#{content.title}\n"
            text << "  #{content.expanded_url}\n\n"
          end
          chatwork.send_message(text)
        end
      end
    end
  end
end