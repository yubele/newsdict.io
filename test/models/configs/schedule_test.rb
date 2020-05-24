require 'test_helper'
class Configs::ScheduleTest < ActiveSupport::TestCase
  test 'last_schedule_at' do
    travel_to Time.zone.local(2020,05,01,15,00,00) do
      schedule = Configs::Schedule.new({
        key: 'last_schedule_at',
        min: 1,
        hour: Configs::Schedule::EVERY,
        wday: 4
      })
      assert_equal schedule.last_schedule_at.class, EtOrbi::EoTime
      assert_equal schedule.last_schedule_at, EtOrbi::EoTime.local(2020, 4, 30, 23, 01, 00)
    end
  end
  test 'next_schedule_at' do
    travel_to Time.zone.local(2020,05,01,15,00,00) do
      schedule = Configs::Schedule.new({
        key: 'next_schedule_at',
        min: Configs::Schedule::EVERY,
        hour: 12,
        wday: 4
      })
      assert_equal schedule.last_schedule_at.class, EtOrbi::EoTime
      assert_equal schedule.next_schedule_at, EtOrbi::EoTime.local(2020, 5, 7, 12, 00, 00)
    end
  end
end