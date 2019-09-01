class Telegram::ScheduleController < Telegram::BaseController
  include Controllers::Telegram::ScheduleSupport

  before_action :check_user_group, except: :set_group!

  rescue_from 'Exceptions::NoGroupAssigned' do |exception|
    send_message t('telegram.schedule.errors.no_group_assigned')
  end

  def yes!(*)
    send_message present_schedule_for(Time.now.prev_day.wday)
  end

  def tod!(*)
    send_message present_schedule_for(Time.now.wday)
  end

  def tom!(*)
    send_message present_schedule_for(Time.now.next_day.wday)
  end

  def tt!(*)
    send_message present_schedule
  end

  def current_group!(*)
    send_message t('telegram.schedule.current_group', group: telegram_user.group.name)
  end

  def set_group!(group_name = nil, *)
    group = Group.find_by(name: group_name)
    return send_message t('telegram.schedule.errors.no_schedule_for_group') unless group

    telegram_user.group = group
    telegram_user.save!

    send_message t('telegram.schedule.success.group_assigned')
  end

  private

  def check_user_group
    raise Exceptions::NoGroupAssigned unless telegram_user.group
  end
end
