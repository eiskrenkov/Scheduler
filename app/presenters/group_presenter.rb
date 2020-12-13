class GroupPresenter < BasePresenter
  attr_reader :group

  def initialize(group)
    @group = group
  end

  def present
    {
      name: group.name,
      weekdays: present_weekdays
    }
  end

  private

  def present_weekdays
    group.schedule.weekdays.map do |weekday|
      WeekdayPresenter.new(weekday).present
    end
  end
end
