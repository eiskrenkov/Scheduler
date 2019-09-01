class Telegram::SchedulePresenter < BasePresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def present
    return unless user.group

    I18n.t('telegram.schedule.header', group: user.group.name) + present_weekdays
  end

  private

  def present_weekdays
    user.group.schedule.weekdays.map do |weekday|
      next if weekday.pairs.blank?

      Telegram::WeekdayPresenter.new(weekday).present
    end.join("\n\n")
  end
end
