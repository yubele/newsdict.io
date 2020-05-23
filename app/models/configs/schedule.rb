module Configs
  class Schedule < ::Config
    field :description, type: String
    field :hour, type: Integer
    field :min, type: Integer
    field :wday, type: Integer
    field :is_active, type: Boolean
    validates :hour, inclusion: -1..23, presence: true
    validates :min, inclusion: -1..59, presence: true
    validates :wday, inclusion: -1..6, presence: true
    has_one :configs_tokens_chatwork, class_name: "Configs::Tokens::Chatwork", autosave: false
    EVERY = -1
    # RailsAdmin Enum
    def hour_enum
      (0..23).map {|n| [n,n]}.push([I18n.t(:everyhour), -1]).to_h
    end
    # RailsAdmin Enum
    def min_enum
      (0..59).map {|n| [n,n]}.push([I18n.t(:everymin), -1]).to_h
    end
    # RailsAdmin Enum
    def wday_enum
      I18n.t("date.abbr_day_names").map.with_index {|n, index| [n, index]}.push([I18n.t(:everyday), -1]).to_h
    end
    # 現在の時刻がhour, min, wdayに該当するか判別する
    # @return Boolean 実行時間に該当すれば true
    def runnable_time?
      now = Time.zone.now
      if runnable_hour?(now) && runnable_min?(now) && runnable_wday?(now)
        return true
      end
    end
    # 前回の実行時刻を取得（実際に実行された時間ではない）
    # @return EtOrbi::EoTime 前回の実行時刻
    def last_schedule_at
      job = Rufus::Scheduler.parse("#{min? ? min : "*"} #{hour? ? hour : "*"} * * #{wday? ? wday : "*"}") do ;end
      job.previous_time
    end
    # 次回の実行時刻を取得（実際に実行された時間ではない）
    # @return EtOrbi::EoTime 次回の実行時刻
    def next_schedule_at
      job = Rufus::Scheduler.parse("#{min? ? min : "*"} #{hour? ? hour : "*"} * * #{wday? ? wday : "*"}") do ;end
      job.next_time
    end
    # Output string of time
    def to_s
      "#{everyhour? ? I18n.t(:everyhour) : format("%02d", hour)}:#{everymin? ? I18n.t(:everymin) : format("%02d", min)} (#{everywday? ? I18n.t(:everyway) : I18n.t('date.abbr_day_names')[wday]})"
    end
    
    private
    # 現在の時間がhourに該当するか判別する
    # @return Boolean 実行時間に該当すれば true
    def runnable_hour?(now)
      if hour == now.hour || hour == Configs::Schedule::EVERY
        return true
      end
    end
    # 現在の分がminに該当するか判別する
    # @return Boolean 実行時間に該当すれば true
    def runnable_min?(now)
      if min == now.min || min == Configs::Schedule::EVERY
        return true
      end
    end
    # 現在の曜日がwdayに該当するか判別する
    # @return Boolean 実行時間に該当すれば true
    def runnable_wday?(now)
      if wday == now.wday || wday == Configs::Schedule::EVERY
        return true
      end
    end
    # 毎分の設定か判別する
    # @return Boolean
    def everymin?
      min == Configs::Schedule::EVERY
    end
    # 毎時の設定か判別する
    # @return Boolean
    def everyhour?
      hour == Configs::Schedule::EVERY
    end
    # 毎週の設定か判別する
    # @return Boolean
    def everywday?
      wday == Configs::Schedule::EVERY
    end
    # 分の設定がされているか判別する
    # @return Boolean
    def min?
      min > Configs::Schedule::EVERY
    end
    # 時の設定がされているか判別する
    # @return Boolean
    def hour?
      hour > Configs::Schedule::EVERY
    end
    # 週の設定がされているか判別する
    # @return Boolean
    def wday?
      wday > Configs::Schedule::EVERY
    end
  end
end