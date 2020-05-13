class Telegram::SchedulePresenter < BasePresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def present
    return unless user.group

    [I18n.t('telegram.schedule.header', group: user.group.name), present_weekdays].join("\n\n")
  end

  private

  def present_weekdays
    user.group.schedule.weekdays.map do |weekday|
      Telegram::WeekdayPresenter.new(weekday).present if weekday.pairs.present?
    end.join("\n\n")
  end
end
