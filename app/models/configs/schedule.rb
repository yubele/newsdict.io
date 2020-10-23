class Configs::Schedule < ::Config
  field :description, type: String
  field :hour, type: Integer
  field :min, type: Integer
  field :wday, type: Integer
  field :category_id, type: BSON::ObjectId
  validates :hour, inclusion: -1..23, presence: true
  validates :min, inclusion: -1..59, presence: true
  validates :wday, inclusion: -1..6, presence: true
  belongs_to :category, class_name: "Configs::Category", required: false
  has_many :posts, class_name: "Posts::Twitter"
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
  def category_id_enum
    Configs::Category.all.map {|c| [c.key, c.id] }.to_h
  end
  # Check to match schedule.
  # @return Boolean
  def runnable_time?
    now = Time.zone.now
    if runnable_hour?(now) && runnable_min?(now) && runnable_wday?(now)
      return true
    end
  end
  # Get a time of last schedule. (Not real execute time)
  # @return EtOrbi::EoTime
  def last_schedule_at
    job = Rufus::Scheduler.parse("#{everymin? ? "*" : min} #{everyhour? ? "*" : hour} * * #{everywday? ? "*" : wday}") do ;end
    job.previous_time
  end
  # Get a time of next schedule. (Not real execute time)
  # @return EtOrbi::EoTime 次回の実行時刻
  def next_schedule_at
    job = Rufus::Scheduler.parse("#{everymin? ? "*" : min} #{everyhour? ? "*" : hour} * * #{everywday? ? "*" : wday}") do ;end
    job.next_time
  end
  # Output string of time
  def to_s
    "#{everyhour? ? I18n.t(:everyhour) : format("%02d", hour)}:#{everymin? ? I18n.t(:everymin) : format("%02d", min)} (#{everywday? ? I18n.t(:everyway) : I18n.t('date.abbr_day_names')[wday]})"
  end

  private
  # Check to match hour.
  # @param [ActiveSupport::TimeWithZone] now
  # @return Boolean
  def runnable_hour?(now)
    if hour == now.hour || hour == Configs::Schedule::EVERY
      return true
    end
  end
  # Check to match min.
  # @param [ActiveSupport::TimeWithZone] now
  # @return Boolean
  def runnable_min?(now)
    if min == now.min || min == Configs::Schedule::EVERY
      return true
    end
  end
  #Check to match wday.
  # @param [ActiveSupport::TimeWithZone] now
  # @return Boolean
  def runnable_wday?(now)
    if wday == now.wday || wday == Configs::Schedule::EVERY
      return true
    end
  end
  # Check to every min.
  # @return Boolean
  def everymin?
    min == Configs::Schedule::EVERY
  end
  # Check to every hour.
  # @return Boolean
  def everyhour?
    hour == Configs::Schedule::EVERY
  end
  # Check to every wday.
  # @return Boolean
  def everywday?
    wday == Configs::Schedule::EVERY
  end

  class << self
    # Get the `Configs::Schedule` of the current time.
    # @return [Configs::Schedule] Instance
    def current
      now = Time.zone.now
      self.and(
        self.or([
          {min: Configs::Schedule::EVERY},
          {min: now.min}]),
        self.or([
          {hour: Configs::Schedule::EVERY},
          {hour: now.hour}]),
        self.or([
          {wday: Configs::Schedule::EVERY},
          {wday: now.wday}]))
    end
  end
end